//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import UIKit

class WelcomeViewController: UIViewController {
    // MARK: - Properties
    
    
    
    // MARK: - UI Elements
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(AuthManager.clientID)
        print(AuthManager.clientSecret)
        print(AuthManager.shared.signInUrl?.absoluteString)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    
    // MARK: - Setup UI
    private func setupUI() {
        self.title = "Spotify"
        self.view.backgroundColor = .systemGreen
        setupButton()
        
    }
    
    private func setupButton() {
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-100-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50)
    }
    
    @objc func didTapSignIn() {
        pushNewVC()
    }
    
    private func pushNewVC() {
        let authVC = AuthViewController()
        authVC.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        authVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(authVC, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // Log user in or check for error
    }

}
