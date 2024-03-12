//
//  EpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 11.03.2024.
//

import UIKit

class EpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "EpisodeInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    func configure(with viewModel: EpisodeInfoCollectionViewCellViewModel) {
        
    }
}
