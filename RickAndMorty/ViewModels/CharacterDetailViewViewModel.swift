//
//  CharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 28.02.2024.
//

import UIKit

final class CharacterDetailViewViewModel {
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }

    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
//    
//    public func fetchCharacterData() {
//        print(character.url)
//        guard let url = requestUrl,
//            let request = Request(url: url) else {
//            return
//        }
//        
//        Service.shared.execute(request, expecting: Character.self) { result in
//            switch result {
//            case .success(let success):
//                print(String(describing: success))
//            case .failure(let failure):
//                print(String(describing: failure))
//            }
//        }
//        
//    }
    
    
    private func setupViews() {
        
    }
}

//MARK: - Set Constraints
extension CharacterDetailViewViewModel {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
