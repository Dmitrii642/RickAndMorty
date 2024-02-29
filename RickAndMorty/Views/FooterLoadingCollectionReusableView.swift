//
//  FooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 28.02.2024.
//

import UIKit

final class FooterLoadingCollectionReusableView: UICollectionReusableView {
        static let identifier = "idFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(spinner)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    public func startAnimation() {
        spinner.startAnimating()
    }
    
    private func setupViews() {
        
    }
}


//MARK: - Set Constraints
extension FooterLoadingCollectionReusableView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
}
