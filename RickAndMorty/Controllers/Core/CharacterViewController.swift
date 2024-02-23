//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.02.2024.
//

import UIKit

final class CharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = Request(endpoint: .character,
                              queryParameters: [
                                URLQueryItem(name: "name", value: "rick"),
                                URLQueryItem(name: "ststus", value: "alive")])
        print(request.url)
        
        Service.shared.execute(request, expecting: Character.self) { result in
            
        }
    }

}
