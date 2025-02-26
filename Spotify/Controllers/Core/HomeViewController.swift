//
//  ViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        fetchData()
    }
    
    private func fetchData() {
        APICaller.shared.getNewRlease { result in
            switch result {
            case .success(let newReleases):
                print("Fetched new releases: \(newReleases)")
            case .failure(let error):
                print("Error fetching new releases: \(error)")
            }
        }
    }
    @objc private func didTapSettings() {
        pushViewController(SettingsViewController(), title: "Settings")
    }
}

