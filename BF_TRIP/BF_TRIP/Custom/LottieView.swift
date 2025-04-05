//
//  LottieView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/12/25.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let fileName: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> UIView {
        let animationView = LottieAnimationView(name: fileName)
        
        animationView.loopMode = loopMode
        animationView.play()
        
        return animationView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    typealias UIViewType = UIView
}
