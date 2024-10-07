//
//  BookmarkView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @State private var text: String = "iPhone"
    
    let webView = WebKit(request: URLRequest(url: URL(string: "http://localhost:5173/")!))
    
    var body: some View {
        VStack {
            webView
                .padding(5)
                .background(.yellow)
                .frame(height: 400)
            
            Button("Call JavaScript Function") {
                webView.callJS()
            }
        }
        .padding()
    }

}
