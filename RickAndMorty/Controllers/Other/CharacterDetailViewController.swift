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
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(viewModel: let viewModel):
            return viewModel.count
        case .episodes(viewModel: let viewModel):
            return viewModel.count
        }
    }
    
    //MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifer,
                for: indexPath) as? CharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.cofigure(with: viewModel)
            return cell
            
        case .information(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterInfoCollectionViewCell.cellIdentifer,
                for: indexPath) as? CharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.cofigure(with: viewModel[indexPath.row])
            return cell
            
        case .episodes(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CharacterEpisodesCollectionViewCell.cellIdentifier,
                for: indexPath) as? CharacterEpisodesCollectionViewCell else {
                fatalError()
            }
            let viewModel = viewModel[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo, .information:
           break
        case .episodes:
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
            let vc = EpisodeDetailViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

