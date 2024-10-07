//
//  MainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct MainView: View {
    
    let webView = WebKit(request: URLRequest(url: URL(string: "http://localhost:5173/")!))
        
    var body: some View {
        VStack {
            webView
        }
    }
}
