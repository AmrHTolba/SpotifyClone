//
//  AuthViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    // MARK: - Properties
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        self.title = "Sign In"
        view.backgroundColor = .systemBackground
        webDelegate()
    }
    
    private func webDelegate() {
        view.addSubview(webView)
        webView.navigationDelegate = self
    }
}

