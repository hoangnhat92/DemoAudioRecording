//
//  ContentView.swift
//  DemoAudioRecording
//
//  Created by nhat on 8/11/24.
//

import SwiftUI

struct ContentView: View {
        
    @StateObject private var audioRecorder = AudioRecorder()
    
    @State private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        
    
    var body: some View {
        VStack {
            Image(systemName: "record.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if audioRecorder.isRecording {
                Text("Recording... will stop in \(audioRecorder.countdown) seconds")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
            } else {
                Text("The app will start recording when it goes into the background")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

            }
            
            if audioRecorder.audioFileName != nil && !audioRecorder.isRecording {
                Button(action: {
                    audioRecorder.playLatestRecording()
                          }) {
                              Text("Play Recording")
                                  .padding()
                                  .background(Color.green)
                                  .foregroundColor(.white)
                                  .cornerRadius(10)
                          }
            }
        }
        .frame(width: 300)
        .padding()
        .preferredColorScheme(.light)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            startBackgroundRecording()
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            endBackgroundTask()
        }
    }
}

extension ContentView {
    
    private func startBackgroundRecording() {
        if backgroundTask == .invalid {
            backgroundTask = UIApplication.shared.beginBackgroundTask {
                endBackgroundTask()
            }
            audioRecorder.startBackgroundRecording()
        }
    }
    
    private func endBackgroundTask() {
          if backgroundTask != .invalid {
              UIApplication.shared.endBackgroundTask(backgroundTask)
              backgroundTask = .invalid
          }
      }
}

#Preview {
    ContentView()
}
