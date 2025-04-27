//
//  SafariItem.swift
//  ast-analysis
//
//  Created by 黃宥琦 on 2025/4/27.
//

import SwiftUI
import SafariServices

struct SafariItem: Identifiable {
    let id = UUID()
    let url: URL
}


struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // 不需要更新
    }
}
