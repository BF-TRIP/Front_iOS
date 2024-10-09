//
//  WebKitView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI
import WebKit
import Combine

class ContentController: NSObject, WKScriptMessageHandler {
    
    var isVoiceViewShowing: Binding<Bool>
    
    init(isVoiceViewShowing: Binding<Bool>) {
        self.isVoiceViewShowing = isVoiceViewShowing
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
            if message.body as! String == "Voice" {
                isVoiceViewShowing.wrappedValue = true
            }
        }
    }
}

struct WebKit: UIViewRepresentable {

    let request: URLRequest
    private var webView: WKWebView?
    
    @Binding var isVoiceViewShowing: Bool

    init(request: URLRequest, isVoiceViewShowing: Binding<Bool>) {
        self.webView = WKWebView()
        self.request = request
//        self.isVoiceViewShowing = isVoiceViewShowing
        self._isVoiceViewShowing = isVoiceViewShowing
        self.webView?.configuration.userContentController.add(
            ContentController(isVoiceViewShowing: isVoiceViewShowing), name: "serverEvent"
        )
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }


    class Coordinator: NSObject {
        let parent: WebKit

        init(parent: WebKit) {
            self.parent = parent
        }
    }
}

extension WebKit {
    func callJS(gpsX: Double, gpsY: Double) {
        webView?.evaluateJavaScript("iOSToJavaScript(gpsX: \(gpsX), gpsY: \(gpsY)") { result, error in
            if let error {
                print("Error \(error.localizedDescription)")
                return
            }
            
            if result == nil {
                print("It's void function")
                return
            }
            
            print("Received Data \(result ?? "")")
        }
    }
}
