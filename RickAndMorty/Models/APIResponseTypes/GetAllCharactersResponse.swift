//
//  GetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 24.02.2024.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Character]
}


