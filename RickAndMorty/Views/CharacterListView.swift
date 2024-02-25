//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 24.02.2024.
//

import UIKit

final class CharacterListView: UIView {
    
    private let viewModel = CharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
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
        viewModel.fetchCharacters()
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
    extension CharacterListView {
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

// MARK: - CharacterListViewModelDelegate
extension CharacterListView: CharacterListViewModelDelegate {
    func didLoadInitalcharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
