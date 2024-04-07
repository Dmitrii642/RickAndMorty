//
//  SearchViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 08.03.2024.
//

import UIKit

final class SearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
            
            var endpoint: EndPoint{
                switch self {
                case .character: return .character
                case .episode: return .episode
                case .location: return .location
                }
            }
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }
        let type: `Type`
    }
    
    private let viewModel: SearchViewViewModel
    private let searchView: SearchView
    
    init(config: Config) {
        let viewModel = SearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = SearchView(frame: .zero, viewModel: SearchViewViewModel(config: config))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapExecuteSearch))
        setDelegate()
    }
    
    private func setDelegate() {
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchView.presentKeyboard()
    }
    
    private func setupViews() {
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
    }
    
    @objc private func didTapExecuteSearch() {
//        viewModel.executeSearch()
    }
    
}

//MARK: - Set Constraints
extension SearchViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchView(_ searchView: SearchView, didSelectOption option: SearchInputViewViewModel.DynamicOption) {
        let vc = SearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
}
