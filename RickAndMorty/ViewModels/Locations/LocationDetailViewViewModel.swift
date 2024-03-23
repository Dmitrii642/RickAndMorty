//
//  LocationDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 21.03.2024.
//

import UIKit

protocol LocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class LocationDetailViewViewModel {
    private let endpointUrl: URL?
    private var dataTuple: (location: Location, characters: [Character])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }

    enum SectionType {
        case information(viewModels: [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [CharacterCollectionViewCellViewModel])
    }

    public weak var delegate: LocationDetailViewViewModelDelegate?

    public private(set) var cellViewModels: [SectionType] = []

    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }

    public func character(at index: Int) -> Character? {
        guard let dataTuple = dataTuple else {
            return nil
        }
        return dataTuple.characters[index]
    }

    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = CharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = CharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels = [.information(viewModels: [
            .init(title: "Location Name", value: location.name),
            .init(title: "Type", value: location.type),
            .init(title: "Dimension", value: location.dimension),
            .init(title: "Created", value: createdString),]),
                          
            .characters(viewModel: characters.compactMap({ character in
                return CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)) }))
        ]
    }
    
    public func fetchLocationData() {
        guard let url = endpointUrl,
              let request = Request(url: url) else {
            return
        }

        Service.shared.execute(request, expecting: Location.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location: model)
            case .failure:
                break
            }
        }
    }

    private func fetchRelatedCharacters(location: Location) {
        let requests: [Request] = location.residents.compactMap({
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
            self.dataTuple = (
                location: location,
                characters: characters
            )
        }
    }
}
