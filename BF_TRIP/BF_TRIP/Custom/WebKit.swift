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
    var isOnboarding: Binding<Bool>
    
    init(isVoiceViewShowing: Binding<Bool>, isOnboarding: Binding<Bool>) {
        self.isVoiceViewShowing = isVoiceViewShowing
        self.isOnboarding = isOnboarding
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            dump("message name : \(message.name)")
            dump("post Message : \(message.body)")
            if message.body as? String == "Voice" {
                isVoiceViewShowing.wrappedValue = true
            } else if message.body as? String == "confirm" {
                dump("message name : \(message.name)")
                dump("post Message : \(message.body)")
            } else {
                isOnboarding.wrappedValue = true
                dump("message name : \(message.name)")
                dump("post Message : \(message.body)")
            }
        }
    }
}

struct WebKit: UIViewRepresentable {

    let request: URLRequest
    var webView: WKWebView
    
    @Binding var isVoiceViewShowing: Bool
    @Binding var isOnboarding: Bool

    init(request: URLRequest, isVoiceViewShowing: Binding<Bool>, isOnboarding: Binding<Bool>) {
        self.webView = WKWebView()
        self.request = request
        self._isVoiceViewShowing = isVoiceViewShowing
        self._isOnboarding = isOnboarding
        self.webView.configuration.userContentController.add(
            ContentController(
                isVoiceViewShowing: isVoiceViewShowing,
                isOnboarding: isOnboarding
            ), name: "serverEvent"
        )
        webView.scrollView.isScrollEnabled = false
        webView.isInspectable = true
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView
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
        webView.evaluateJavaScript("iOSToJavaScript(\(gpsX), \(gpsY))") { result, error in
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
    
    func sendUUID() {
        let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
        dump(deviceUUID)
        webView.evaluateJavaScript("iOSToJavaScript(\(deviceUUID))") { result, error in
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
