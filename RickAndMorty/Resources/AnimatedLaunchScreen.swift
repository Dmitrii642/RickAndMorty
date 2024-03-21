//
//  AnimatedLaunchScreen.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 15.03.2024.
//

import UIKit

final class AnimatedLaunchScreen: UIViewController {
    
    private let logoImageView: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "Logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    private let loadingImageView: UIImageView = {
        let loadingImage = UIImageView()
        loadingImage.image = UIImage(named: "Loading")
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        return loadingImage
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let tabViewController = TabViewController()
            tabViewController.modalPresentationStyle = .fullScreen
            self.present(tabViewController, animated: true, completion: nil)
        }
    }
    
    private func animateLoading() {
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            options: [.curveLinear],
            animations: {
                self.loadingImageView.transform = self.loadingImageView.transform.rotated(by: .pi)
            },
            completion: { isComplete in
                if isComplete {
                    self.animateLoading()
                }
            }
        )
    }
    
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        view.addSubview(loadingImageView)
    }
}

//MARK: - Set Constraints
extension AnimatedLaunchScreen {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoImageView.heightAnchor.constraint(equalToConstant: 104),
            
            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingImageView.widthAnchor.constraint(equalToConstant: 300),
            loadingImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
