//
//  EpisodeViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.02.2024.
//

import UIKit

final class EpisodeViewController: UIViewController {

    private let episodeListView = EpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        addSearchButton()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Episodes"
        view.addSubview(episodeListView)
    }
    
    private func setDelegates(){
        episodeListView.delegate = self
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        
    }
}

// MARK: - Set Constraints
extension EpisodeViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - EpisodeListViewDelegate
extension EpisodeViewController: EpisodeListViewDelegate {
    func episodeListView(_ episodeListView: EpisodeListView, didSelectEpisode episode: Episode) {
        let detailVC = EpisodeDetailViewController(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
