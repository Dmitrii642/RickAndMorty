//
//  SearchInputView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 23.03.2024.
//


import UIKit

final class SearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: SearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            let options = viewModel.options
            createOptionSelectionViews(options: options)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemRed
        
        addSubviews(searchBar)
    }
    
    public func configure(with viewModel: SearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    private func createOptionSelectionViews(options: [SearchInputViewViewModel.DynamicOption]) {
        for option in options {
            print(option.rawValue)
    }
    }
}

//MARK: - Set Constraints
extension SearchInputView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor ),
            searchBar.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
}
