//
//  LocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 15.03.2024.
//

import UIKit

protocol LocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class LocationViewViewModel {
    
    weak var delegate: LocationViewViewModelDelegate?
    
    private var locations: [Location] = [] {
        didSet {
            for location in locations {
                let cellViewModel = LocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    public private(set) var cellViewModels: [LocationTableViewCellViewModel] = []
    
    private var apiInfo: GetLocationsResponse.Info?
    
    init() {}
    
    public func location(at index: Int) -> Location? {
        guard index >= locations.count else {
            return nil
        }
        return self.locations[index]
    }
    
    public func fetchLocations() {
        Service.shared.execute(.listLocationsRequest, expecting: GetLocationsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let error):
                break
            }
        }
    }
    
    public var hasMoreResults: Bool {
        return false
    }
}
