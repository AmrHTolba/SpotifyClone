//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeNav    = createNavBarController(for: HomeViewController(), titleDisplayMode: .always, titled: "Home")
        let searchNav  = createNavBarController(for: SearchViewController(), titleDisplayMode: .always, titled: "Search")
        let libraryNav = createNavBarController(for: LibraryViewController(), titleDisplayMode: .always, titled: "Library")
        
        homeNav.navigationBar.prefersLargeTitles    = true
        searchNav.navigationBar.prefersLargeTitles  = true
        libraryNav.navigationBar.prefersLargeTitles = true
        
        homeNav.tabBarItem    = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchNav.tabBarItem  = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        libraryNav.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "books.vertical"), tag: 1)
        
        viewControllers = [homeNav, searchNav, libraryNav]
    }
    
    private func createNavBarController(for rootViewController: UIViewController,  titleDisplayMode: UINavigationItem.LargeTitleDisplayMode, titled: String) -> UINavigationController {
        rootViewController.title = titled
        rootViewController.navigationItem.largeTitleDisplayMode = titleDisplayMode
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
