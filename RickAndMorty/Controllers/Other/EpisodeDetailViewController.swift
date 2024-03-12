//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 06.03.2024.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {
    
    private let viewModel: EpisodeDetailViewViewModel
    private let detailView = EpisodeDetailView()
    
    
    init(url: URL?) {
        self.viewModel = EpisodeDetailViewViewModel(endpointUrl: url)
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
        title = "Episode"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        view.addSubviews(detailView)
        viewModel.fetchEpisodeData()
    }
    
    private func setupDelegate() {
        viewModel.delegate = self
        detailView.delegate = self
    }
    
    @objc private func didTapShare() {
        
    }
    
    
}

//MARK: - Set Constraints
extension EpisodeDetailViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - EpisodeDetailViewViewModelDelegate
extension EpisodeDetailViewController: EpisodeDetailViewViewModelDelegate {
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
}

//MARK: - EpisodeDetailViewDelegate
extension EpisodeDetailViewController: EpisodeDetailViewDelegate {
    func episodeDetailView(_ detailView: EpisodeDetailView, didSelect character: Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
