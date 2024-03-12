//
//  GetAllEpisodesResponse.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 08.03.2024.
//

import Foundation

struct GetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Episode]
}

