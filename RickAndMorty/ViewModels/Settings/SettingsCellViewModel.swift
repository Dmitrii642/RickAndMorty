//
//  SettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Dmitrii Iakovlev on 12.03.2024.
//
 
import UIKit

struct SettingsCellViewModel: Identifiable {
    let id = UUID()
    
    
    public let type: SettingsOption
    public let onTapHandler: (SettingsOption) -> Void
    
    init(type: SettingsOption, onTapHandler: @escaping(SettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    public var image: UIImage? {
        return type.icomImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
