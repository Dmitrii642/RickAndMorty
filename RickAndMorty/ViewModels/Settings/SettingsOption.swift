//
//  SettingsOption.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 12.03.2024.
//

import UIKit

enum SettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://t.me/dima_iakovlev")
        case .terms:
            return URL(string: "https://iosacademy.io/terms")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation/#get-a-single-episode")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/Dmitrii642/RickAndMorty")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Referenec"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
            switch self {
            case .rateApp:
                return .systemBlue
            case .contactUs:
                return .systemGreen
            case .terms:
                return .systemRed
            case .privacy:
                return .systemYellow
            case .apiReference:
                return .systemOrange
            case .viewSeries:
                return .systemPurple
            case .viewCode:
                return .systemPink
            }
        }
        
        var icomImage: UIImage? {
            switch self {
            case .rateApp:
                return UIImage(systemName: "star.fill")
            case .contactUs:
                return UIImage(systemName: "paperplane")
            case .terms:
                return UIImage(systemName: "doc")
            case .privacy:
                return UIImage(systemName: "lock")
            case .apiReference:
                return UIImage(systemName: "list.clipboard")
            case .viewSeries:
                return UIImage(systemName: "tv.fill")
            case .viewCode:
                return UIImage(systemName: "hammer.fill")
            }
    }
}


