//
//  TabViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.02.2024.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabs()
        
    }

    private func setUpTabs() {
        let charactersVC = CharacterViewController()
        let locationsVC = LocationViewController()
        let episodesVC = EpisodeViewController()
        let settingsVC = SettingsViewController()
        
        let nav1 = UINavigationController(rootViewController: charactersVC)
        let nav2 = UINavigationController(rootViewController: locationsVC)
        let nav3 = UINavigationController(rootViewController: episodesVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }

}

