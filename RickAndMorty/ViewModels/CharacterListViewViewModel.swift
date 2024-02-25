//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 24.02.2024.
//

import UIKit

protocol CharacterListViewModelDelegate: AnyObject {
    func didLoadInitalcharacters()
}

final class CharacterListViewViewModel: NSObject {
    
    public weak var delegate: CharacterListViewModelDelegate?
    
    private var characters: [Character] = [] {
        didSet {
            for character in characters {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                cellViewModel.append(viewModel)
            }
        }
    }
    
    
    private var cellViewModel: [CharacterCollectionViewCellViewModel] = []
    
   public func fetchCharacters() {
        Service.shared.execute(.listCharactersrequests,
                               expecting: GetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitalcharacters()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
           for: indexPath) as? CharacterCollectionViewCell else {
           fatalError("Unsupported cell")
       }
        let viewModel = cellViewModel[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30) / 2
        return CGSize(width: width,
                      height: width * 1.5)
    }
}
