//
//  CharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 25.02.2024.
//

import Foundation

final class CharacterCollectionViewCellViewModel {
    
    public let characterName: String
    private let characterStatus: CharacterStatus
    private let characterImageUrl: URL?
    
    init(characterName: String, characterStatus: CharacterStatus, characterImageUrl: URL?) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}

//MARK: - Hashable, Equatable 
extension CharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    static func == (lhs: CharacterCollectionViewCellViewModel, rhs: CharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}

