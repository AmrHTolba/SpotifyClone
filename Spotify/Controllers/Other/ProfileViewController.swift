//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 24/02/2025.
//

import UIKit

class ProfileViewController: UIViewController {

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - SetupUI
    private func setupUI() {
        self.title = "Profile"
        APICaller.shared.getCurrentUserProfile { results in
            switch results {
            case .success(let model):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
