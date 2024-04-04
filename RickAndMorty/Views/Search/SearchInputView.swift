//
//  SearchInputView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 23.03.2024.
//


import UIKit

protocol SearchInputViewDelegate: AnyObject {
    func searchInputView(_ inputView: SearchInputView, didSelectOption option: SearchInputViewViewModel.DynamicOption)
}

final class SearchInputView: UIView {
    
    weak var delegate: SearchInputViewDelegate?
    
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
        
        addSubviews(searchBar)
    }
    
    public func configure(with viewModel: SearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor ),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return stackView
    }
    
    private func createOptionSelectionViews(options: [SearchInputViewViewModel.DynamicOption]) {
        let stackView = createOptionStackView()
        
        for x in 0..<options.count {
            let option = options[x]
            let button = createButton(with: option, tag: x)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(with option: SearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
        let button = UIButton()
        
        button.setAttributedTitle(NSAttributedString(
            string: option.rawValue,
            attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium),
                         .foregroundColor: UIColor.label]),
            for: .normal)
        
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 6
        
        return button
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else {
            return
        }
        let tag = sender.tag
        let selected = options[tag]
        delegate?.searchInputView(self, didSelectOption: selected)
        
        print("Did tap \(selected.rawValue)")
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
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
