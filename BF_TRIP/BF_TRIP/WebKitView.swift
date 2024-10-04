//
//  WebKitView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI
import WebKit

struct WebKit: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: "url") else { return WKWebView() }
        
        let webView = WKWebView()
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.alwaysBounceHorizontal = false
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebKit>) {
        guard let url = URL(string: url) else { return }
        
        webView.load(URLRequest(url: url))
    }
}
