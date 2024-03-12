//
//  EpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 07.03.2024.
//

import UIKit

protocol EpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class EpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    private var dataTuple: (episode: Episode, characters: [Character])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModel: [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [CharacterCollectionViewCellViewModel])
    }
    
   public private(set) var cellViewModels: [SectionType] = []
    
   public weak var delegate: EpisodeDetailViewViewModelDelegate?
    
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        cellViewModels = [
            .information(viewModel: [.init(title: "Episode name", value: episode.name),
                                     .init(title: "Air Date", value: episode.air_date),
                                     .init(title: "Episode", value: episode.episode),
                                     .init(title: "Created", value: episode.created)]),
            .characters(viewModel: characters.compactMap({ character in
                return CharacterCollectionViewCellViewModel(
                    characterName: character  .name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
            }))
        ]
    }
    
    public func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = Request(url: url) else {
            return
        }
        Service.shared.execute(request, expecting: Episode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure:
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: Episode) {
        let requests: [Request] = episode.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return Request(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [Character] = []
        for request in requests {
            group.enter()
            Service.shared.execute(request, expecting: Character.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (episode: episode, characters: characters)
        }
    }
}
