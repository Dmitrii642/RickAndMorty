//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 28.02.2024.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewViewModel
    
    private let detailView = CharacterDetailView()
    
    
    init(viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
        view.addSubviews(detailView)
        setConstraints()
    }
    
    @objc private func didTapShare() {
        print("Tap")
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        
    }
}

//MARK: - Set Constraints
extension CharacterDetailViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
