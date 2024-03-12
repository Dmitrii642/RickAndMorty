//
//  EpisodeListView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 07.03.2024.


import UIKit

protocol EpisodeListViewDelegate: AnyObject {
    func episodeListView(_ episodeListView: EpisodeListView, didSelectEpisode episode: Episode)
}

final class EpisodeListView: UIView {
    
    public weak var delegate: EpisodeListViewDelegate?
    
    private let viewModel = EpisodeListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CharacterEpisodesCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterEpisodesCollectionViewCell.cellIdentifier)
        
        collectionView.register(FooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(collectionView, spinner)
        setConstraints()
        setUpCollectionView()
        
        spinner.startAnimating()
        
        viewModel.delegate = self
        viewModel.fetchEpisodes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
}
    // MARK: - Set Constraints
    extension EpisodeListView {
        private func setConstraints() {
            NSLayoutConstraint.activate([
                spinner.widthAnchor.constraint(equalToConstant: 100),
                spinner.heightAnchor.constraint(equalToConstant: 100),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }

// MARK: - EpisodeListViewModelDelegate
extension EpisodeListView: EpisodeListViewViewModelDelegate {
    
    func didSelectEpisode(_ episode: Episode) {
        delegate?.episodeListView(self, didSelectEpisode: episode)
    }
    
    func didLoadInitalEpisodes() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
}
