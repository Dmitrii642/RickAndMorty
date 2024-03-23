//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.03.2024.
//

import UIKit

final class LocationDetailViewController: UIViewController {
    
    private let viewModel: LocationDetailViewViewModel
    private let detailView = LocationDetailView()
    
    
    init(location: Location) {
        let url = URL(string: location.url)
        self.viewModel = LocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegate()
    }
    
    private func setupViews() {
        title = "Location"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        view.addSubviews(detailView)
        viewModel.fetchLocationData()
    }
    
    private func setupDelegate() {
        viewModel.delegate = self
        detailView.delegate = self
    }
    
    @objc private func didTapShare() {
        
    }
    
    
}

//MARK: - Set Constraints
extension LocationDetailViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - LocationDetailViewViewModelDelegate
extension LocationDetailViewController: LocationDetailViewViewModelDelegate {
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}

//MARK: - LocationDetailViewDelegate
extension LocationDetailViewController: LocationDetailViewDelegate {
    func episodeDetailView(_ detailView: LocationDetailView, didSelect character: Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
