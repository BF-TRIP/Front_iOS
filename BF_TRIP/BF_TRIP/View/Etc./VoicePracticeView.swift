//
//  VoicePracticeView.swift
//  BF_TRIP
//
//  Created by 박동재 on 9/30/24.
//

import SwiftUI

struct VoicePracticeView: View {
    @StateObject var audioRecorderManager = AudioRecorderManager()

    var body: some View {
        VStack {
           
            RecordingStatusView(audioRecorderManager: audioRecorderManager)
            
            RecordingButtonView(audioRecorderManager: audioRecorderManager)
            
            RecordingListView(audioRecorderManager: audioRecorderManager)
            
            Button {
                guard let fileURL = audioRecorderManager.recordedFile.last else { return }

                MoyaManager.shared.fileToList(fileURL: fileURL) { result in
                    switch result {
                    case .success(let data):
                        dump(data)
                    case .failure(let error):
                        dump(error.localizedDescription)
                    }
                }
            } label: {
                Text("음성보내기 연습!")
            }

        }
    }
}

private struct RecordingStatusView: View {
    
    @ObservedObject private var audioRecorderManager: AudioRecorderManager
    
    fileprivate init(audioRecorderManager: AudioRecorderManager) {
        self.audioRecorderManager = audioRecorderManager
    }
    
    var body: some View {
        if audioRecorderManager.isRecording {
            Text("Recording...")
                .foregroundColor(.red)
        } else {
            Text("Waiting...")
        }
    }
    
}

private struct RecordingButtonView: View {
    
    @ObservedObject private var audioRecorderManager: AudioRecorderManager
    
    fileprivate init(audioRecorderManager: AudioRecorderManager) {
        self.audioRecorderManager = audioRecorderManager
    }
    
    var body: some View {
        HStack {
            Button {
                audioRecorderManager.isRecording
                ? audioRecorderManager.stopRecording()
                : audioRecorderManager.startRecording()
            } label: {
                Text(audioRecorderManager.isRecording ? "종료" : "시작")
                    .foregroundColor(.white)
                    .padding()
                    .background(audioRecorderManager.isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
        }
    }
    
}

private struct RecordingListView: View {
    
    @ObservedObject private var audioRecorderManager: AudioRecorderManager
    
    fileprivate init(audioRecorderManager: AudioRecorderManager) {
        self.audioRecorderManager = audioRecorderManager
    }
    
    var body: some View {
        List {
            ForEach(audioRecorderManager.recordedFile, id: \.self) { recordedFile in
                Button {
                    if audioRecorderManager.isPlaying && audioRecorderManager.audioPlayer?.url == recordedFile {
                        audioRecorderManager.isPaused
                        ? audioRecorderManager.resumePlaying()
                        : audioRecorderManager.pausePlaying()
                    } else {
                        audioRecorderManager.startPlaying(recordingURL: recordedFile)
                    }
                } label: {
                    Text(recordedFile.lastPathComponent)
                        .foregroundColor(
                            audioRecorderManager.isPlaying && audioRecorderManager.audioPlayer?.url == recordedFile
                            ? (audioRecorderManager.isPaused ? .green : .red)
                            : .black
                        )
                }

            }
        }
    }
    
}


#Preview {
    VoicePracticeView()
}
