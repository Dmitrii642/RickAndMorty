//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 28.02.2024.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewViewModel
    
    private let detailView: CharacterDetailView
    
    
    init(viewModel: CharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = CharacterDetailView(frame: .zero, viewModel: viewModel)
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
        setDelegates()
    }
    
    @objc private func didTapShare() {
        print("Tap")
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    private func setDelegates() {
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 8
        case 2:
            return 20
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.backgroundColor = .systemPink
        } else  if indexPath.section == 1 {
            cell.backgroundColor = .systemCyan
        } else {
            cell.backgroundColor = .systemBlue
        }
        return cell
    }
}
