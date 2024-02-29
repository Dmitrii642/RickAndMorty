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

    
    public var title: String {
        character.name.uppercased()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
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
