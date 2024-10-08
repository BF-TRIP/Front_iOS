//
//  VoiceView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/9/24.
//

import SwiftUI

struct VoiceView: View {
    
    @StateObject var audioRecorderManager = AudioRecorderManager()
    
    @Binding var isVoiceViewShowing: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        self.isVoiceViewShowing.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .padding(.horizontal, 15)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                
                Spacer()
                
                Text("듣고 있어요!")
                    .foregroundColor(Color(.label))
                    .font(.system(size: 28))
                    .padding()
                Text("공원, 바다, 박물관과 같은")
                    .foregroundColor(Color(hex: "#A1A5AC"))
                    .font(.system(size: 20))
                Text("장소 키워드를 말해주세요.")
                    .foregroundColor(Color(hex: "#A1A5AC"))
                    .font(.system(size: 20))
                
                Image(uiImage: .mic)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .tint(Color(hex: "#FFE023"))
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 450)
            .background(Color(hex: "#F6F5FA"))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.black).opacity(0.4))
        .background(ClearBackground())
    }
}

public struct ClearBackground: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> some UIView {
        let view = ClearBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}

final class ClearBackgroundView: UIView {
    
    public override func layoutSubviews() {
        guard let parantView = superview?.superview else {
            return
        }
        parantView.backgroundColor = .clear
    }
    
}
