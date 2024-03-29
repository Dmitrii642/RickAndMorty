//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 22.02.2024.
//

import Foundation

enum CharacterStatus: String, Codable {
case alive = "Alive"
case dead = "Dead"
case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
