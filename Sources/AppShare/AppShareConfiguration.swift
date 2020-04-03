//
//  AppShareConfiguration.swift
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

import Foundation

public struct AppShareConfiguration {
    public var titleText: String?
    public var descriptionText: String
    
    public init(titleText: String?, descriptionText: String) {
        self.titleText = titleText
        self.descriptionText = descriptionText
    }
        
    var hasTitle: Bool { titleText != nil }
}

extension AppShareConfiguration {
    
    public static let `default` = AppShareConfiguration(
        titleText: .localizedString("defaultTitle"),
        descriptionText: .localizedString("defaultDescription")
    )
    
}
