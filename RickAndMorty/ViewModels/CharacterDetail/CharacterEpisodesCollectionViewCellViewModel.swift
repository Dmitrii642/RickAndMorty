//
//  CharacterEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 05.03.2024.
//

import UIKit

protocol EpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class CharacterEpisodesCollectionViewCellViewModel: Hashable, Equatable {
    
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((EpisodeDataRender) -> Void)?
    
    public let borderColor: UIColor
    
    private var episode: Episode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    init(episodeDataUrl: URL?, borderColor: UIColor = .systemBlue) {
        self.episodeDataUrl = episodeDataUrl
        self.borderColor = borderColor
    }
    
    public func registerForData(_ block: @escaping(EpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl,
              let request = Request(url: url) else {
            return
        }
        isFetching = true
        Service.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
                
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (lhs: CharacterEpisodesCollectionViewCellViewModel, rhs: CharacterEpisodesCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
