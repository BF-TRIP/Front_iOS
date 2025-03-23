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
    var showOnboarding: Binding<Bool?>
    
    init(isVoiceViewShowing: Binding<Bool>, isOnboarding: Binding<Bool>, showOnboarding: Binding<Bool?>) {
        self.isVoiceViewShowing = isVoiceViewShowing
        self.isOnboarding = isOnboarding
        self.showOnboarding = showOnboarding
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            dump("message name : \(message.name)")
            dump("post Message : \(message.body)")
            if message.body as? String == "Voice" {
                isVoiceViewShowing.wrappedValue = true
            } else if message.body as? String == "confirm" {
                isOnboarding.wrappedValue = true
            } else if message.body as? String == "quit" {
                showOnboarding.wrappedValue = nil
                DataManager.shared.deleteUserId()
                DataManager.shared.deleteUserName()
            } else {
                dump("그런 메시지가 없습니다.")
            }
        }
    }
}

struct WebKit: UIViewRepresentable {

    let request: URLRequest
    var webView: WKWebView
    
    @Binding var isVoiceViewShowing: Bool
    @Binding var isOnboarding: Bool

    init(
        request: URLRequest,
        isVoiceViewShowing: Binding<Bool>,
        isOnboarding: Binding<Bool>,
        showOnboarding: Binding<Bool?>
    ) {
        self.webView = WKWebView()
        self.request = request
        self._isVoiceViewShowing = isVoiceViewShowing
        self._isOnboarding = isOnboarding
        self.webView.configuration.userContentController.add(
            ContentController(
                isVoiceViewShowing: isVoiceViewShowing,
                isOnboarding: isOnboarding,
                showOnboarding: showOnboarding
            ), name: "serverEvent"
        )
        webView.scrollView.isScrollEnabled = true
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

    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: WebKit

        init(parent: WebKit) {
            self.parent = parent
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.y < 0 {
                scrollView.contentOffset.y = 0
            }
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
        guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else { return }
        dump(deviceUUID)
//        webView.evaluateJavaScript("iOSToJavaScript(\(deviceUUID));") { result, error in
        webView.evaluateJavaScript("iOSToJavaScript('\(deviceUUID)')")  { result, error in
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
