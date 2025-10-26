//
//  UserAgreementView.swift
//  TravelSchedules
//
//  Created by Pavel Komarov on 16.10.2025.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    @Environment(\.dismiss) private var dismiss
    let url: URL
    
    var body: some View {
        ZStack {
            Color.yWhite.ignoresSafeArea()
            WebView(url: url)
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton(dismiss: dismiss)
    }
}

private struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        if uiView.url != url {
            uiView.load(request)
        }
    }
}

#Preview {
    NavigationStack {
        UserAgreementView(url: URL(string: "https://yandex.ru/legal/rasp/?lang=ru")!)
    }
}
