---

# Audio Recorder App

This is a Swift-based audio recording app that allows users to record audio, automatically save the recording, and play back the latest recording. The app supports background recording for a limited time (up to 15 seconds) when it moves to the background. This functionality is achieved using `AVAudioSession`, `AVAudioRecorder`, and `AVAudioPlayer`.

## Features

- **Audio Recording**: Records audio with a countdown timer displayed in the app.
- **Background Recording**: Continues recording audio for 15 seconds when the app moves to the background, then automatically stops and saves the recording.
- **Playback**: Allows the user to play back the latest recorded audio.
- **Countdown Timer**: Shows a countdown timer during recording, which stops the recording after 15 seconds if not manually stopped.

## Technical Overview

### Core Technologies

- **AVAudioSession**: Configured to allow background audio recording using the `.playAndRecord` category and specific category options.
- **AVAudioRecorder**: Handles audio recording with specific settings (AAC encoding, 12 kHz sample rate, etc.).
- **AVAudioPlayer**: Allows playback of the most recent recording.
- **SwiftUI**: Manages the user interface, with buttons for recording, stopping, and playing back audio.

### Background Audio Recording

To enable background recording, the app:
1. Configures `AVAudioSession` with the `.playAndRecord` category.
2. Sets the app’s **Signing & Capabilities** to enable **Background Modes** with the **Audio** option.
3. Manages background tasks with `UIBackgroundTaskIdentifier` to allow continued operation when the app moves to the background.

**Note**: iOS limits background recording time for apps, so the app will only record for up to 15 seconds after entering the background, then automatically stops and saves the recording.

### Permissions

The app requires:
- **Microphone Access**: To record audio, the app must request permission to access the microphone.

## Project Structure

- **AudioRecorder.swift**: Handles all audio recording, background task management, and playback functionality.
- **AudioRecorderView.swift**: SwiftUI view that provides the UI for recording and playing audio, displaying a countdown timer during recording.
- **Info.plist**: Contains permissions for microphone usage and photo library access.

## How to Run the Project

### Prerequisites

- **Xcode 12 or later**
- **iOS 14 or later**

### Steps to Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/hoangnhat92/DemoAudioRecording.git
   ```

2. **Open the project in Xcode**:
   Open `DemoAudioRecording.xcodeproj` in Xcode.

3. **Configure Signing**:
   - Select the project in Xcode.
   - Go to the **Signing & Capabilities** tab.
   - Under **Signing**, select your team or add a new signing certificate if required.

4. **Enable Background Modes**:
   - In **Signing & Capabilities**, ensure that **Background Modes** is enabled with the **Audio** option checked.

5. **Build and Run**:
   - Build and run the app on a physical iOS device, as background recording may not work as expected on the simulator.

6. **Grant Permissions**:
   - The app will request access to the microphone. Grant this permissions when prompted.

### Usage Instructions

- **Start Recording**: Tap the "Start Recording" button to begin recording. A countdown timer will start from 15 seconds.
- **Stop Recording**: Tap the "Stop Recording" button to stop recording manually. The recording will automatically save.
- **Play Latest Recording**: Tap the "Play Latest Recording" button to play back the most recent recording.

## Screenshot
<img width="510" alt="Screenshot 2024-11-08 at 20 14 27" src="https://github.com/user-attachments/assets/d4c5c75e-5bae-4118-afe7-ea90de7e35bb">




---
