//
//  SettingsViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.02.2024.
//

import UIKit
import SwiftUI
import SafariServices

final class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    private var settingsSwiftUIController: UIHostingController<SettingsView>?
    
    
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        addSwiftUIController()
    }
    
    private func addSwiftUIController() {
        let settingsSwiftUIController = UIHostingController(rootView: SettingsView(viewModel: SettingsViewViewModel(cellViewModels: SettingsOption.allCases.compactMap({
            return SettingsCellViewModel(type: $0) { [weak self] option in
                self?.handlerTap(option: option)
                print(option.displayTitle)
            }
        })
     )
   )
)
        
        addChild(settingsSwiftUIController)
        
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubviews(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsSwiftUIController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handlerTap(option: SettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            
        } else if option == .rateApp {
            
        }
    }
}
