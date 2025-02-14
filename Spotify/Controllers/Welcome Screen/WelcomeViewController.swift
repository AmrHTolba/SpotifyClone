//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    // MARK: - Setup UI
    private func setupUI() {
        self.title = "Spotify"
        self.view.backgroundColor = .systemGreen
    }

}
