//
//  AudioRecorder.swift
//  DemoAudioRecording
//
//  Created by nhat on 8/11/24.
//

import AVFoundation

class AudioRecorder: NSObject, AVAudioRecorderDelegate, ObservableObject {
    
    @Published var countdown: Int = 15
    @Published var isRecording: Bool = false
    
    var audioRecorder: AVAudioRecorder?
    
    var recordingSession: AVAudioSession?
    
    var stopTimer: Timer?
    
    private var countdownTimer: Timer?
    
    @Published var audioFileName: URL?
    
    private var audioPlayer: AVAudioPlayer?


    override init() {
        super.init()
        
        // Configure the recording session
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .default,  options: [.defaultToSpeaker, .allowBluetooth])
            try recordingSession?.setActive(true)
            
            // Request permission to record
            recordingSession?.requestRecordPermission { allowed in
                if !allowed {
                    print("Permission to record not granted.")
                }
            }
        } catch {
            print("Failed to configure the recording session: \(error)")
        }
    }

    func startRecording() {
        audioFileName = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).m4a")

        print("Audio filename: \(audioFileName!.path)")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName!, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
            isRecording = true
            countdown = 15
            startCountdownTimer()

            print("Recording started.")
        } catch {
            print("Failed to start recording: \(error)")
            audioRecorder = nil
        }
    }
    
    func playLatestRecording() {
        guard let latestRecording = audioFileName else {
               print("No recording found to play.")
               return
           }
           
           do {
               audioPlayer = try AVAudioPlayer(contentsOf: latestRecording)
               audioPlayer?.play()
               print("Playing latest recording.")
           } catch {
               print("Failed to play recording: \(error)")
           }
       }
    
    func startBackgroundRecording() {
           startRecording()
           stopTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { _ in
               self.stopRecording()
           }
       }


    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        
        countdown = 0
        isRecording = false
        countdownTimer?.invalidate()
        countdownTimer = nil
        print("Recording stopped.")
    }
    
    private func startCountdownTimer() {
          countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
              guard let self = self else { return }
              if self.countdown > 0 {
                  self.countdown -= 1
              } else {
                  self.stopRecording()
              }
          }
      }

    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // Optional: AVAudioRecorderDelegate methods to handle completion
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully.")
        } else {
            print("Recording failed.")
        }
    }
}
