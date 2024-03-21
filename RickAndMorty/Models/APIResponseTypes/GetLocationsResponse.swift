//
//  GetLocationsResponse.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 20.03.2024.
//

import Foundation

struct GetLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Location]
}
