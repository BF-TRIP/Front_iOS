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
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            print("message name : \(message.name)")
            print("post Message : \(message.body)")
        }
    }
}

struct WebKit: UIViewRepresentable {

    let request: URLRequest
    private var webView: WKWebView?

    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
        self.webView?.configuration.userContentController.add(ContentController(), name: "serverEvent")
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
    func callJS(_ args: Any = "") {
        webView?.evaluateJavaScript("iOSToJavaScript('\(args)')") { result, error in
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
