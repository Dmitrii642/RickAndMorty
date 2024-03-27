//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 23.03.2024.
//

import UIKit

final class SearchView: UIView {
    
    private let viewModel: SearchViewViewModel
    private let noResultsView = NoSearchResultsView()
    
     init(frame: CGRect, viewModel: SearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    private func setupViews() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(noResultsView)
    }
}

//MARK: - Set Constraints
extension SearchView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension SearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
}

//MARK: - UICollectionViewDataSource
extension SearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
