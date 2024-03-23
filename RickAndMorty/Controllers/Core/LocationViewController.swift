//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.02.2024.
//

import UIKit

final class LocationViewController: UIViewController {
    
    private let primaryView = LocationView()
    private let viewModel = LocationViewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addSearchButton()
        setDelegate()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Locations"
        
        view.addSubview(primaryView)
        viewModel.fetchLocations()
    }
    
    private func setDelegate() {
        viewModel.delegate = self
        primaryView.delegate  = self
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
    
}

//MARK: - Set Constraints
extension LocationViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - LocationViewViewModelDelegate
extension LocationViewController: LocationViewViewModelDelegate {
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}

//MARK: - LocationViewDelegate
extension LocationViewController: LocationViewDelegate {
    func locationView(_ loactionView: LocationView, didSelect location: Location) {
        let vc = LocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
