//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 24/02/2025.
//

import UIKit
import SDWebImage
import StoreKit

class ProfileViewController: UIViewController {
    // MARK: - Properties
    private var models = [String]()
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - SetupUI
    private func setupUI() {
        self.title = "Profile"
        view.backgroundColor = .systemBackground
        setupTableViewDelegate()
        setupTableView()
        fetchProfile()
    }
    
    private func setupTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
    }
    
    // MARK: - Class Methods
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] results in
            DispatchQueue.main.async{
                switch results {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Profile Error \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Full Name: \(model.displayName)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first?.url)
        
        tableView.reloadData()
    }
    private func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else { return }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.width/1.5))
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        imageView.sd_setImage(with: url, completed: nil)
        
        tableView.tableHeaderView = headerView
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to get profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
        
    }
}

// MARK: - UI Table View
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
