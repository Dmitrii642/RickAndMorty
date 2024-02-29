//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 28.02.2024.
//


import UIKit

final class CharacterDetailView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        
    }
}

//MARK: - Set Constraints
extension CharacterDetailView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
