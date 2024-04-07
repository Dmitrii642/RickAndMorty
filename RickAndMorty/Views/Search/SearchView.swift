//
//  SearchView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 23.03.2024.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchView(_ searchView: SearchView, didSelectOption option: SearchInputViewViewModel.DynamicOption)
}

final class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?
    
    private let viewModel: SearchViewViewModel
    private let noResultsView = NoSearchResultsView()
    private let searchInputView = SearchInputView()
    
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
        
        addSubviews(noResultsView, searchInputView)
        searchInputView.configure(with: SearchInputViewViewModel(type: viewModel.config.type))
        searchInputView.delegate = self
        
        viewModel.registerOptionChangeBlock { tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
}

//MARK: - Set Constraints
extension SearchView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
            
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

//MARK: - SearchInputViewDelegate
extension SearchView: SearchInputViewDelegate {
    func searchInputView(_ inputView: SearchInputView, didSelectOption option: SearchInputViewViewModel.DynamicOption) {
        delegate?.searchView(self, didSelectOption: option)
    }
}
