//
//  EndPoint.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 22.02.2024.
//

import Foundation

@frozen enum EndPoint: String, Hashable, CaseIterable {
    case character
    case location
    case episode
}
