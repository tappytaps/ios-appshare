//
//  UIImage+Bundle.swift
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

import UIKit

extension Bundle {
    
    static var resources: Bundle? {
        guard let resourcesBundleUrl = Bundle(for: ShareServiceCell.self).url(forResource: "AppShareResources", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: resourcesBundleUrl)
    }
    
}

extension UIImage {
    
    static func bundleImage(named imageName: String) -> UIImage? {
        guard let resourcesBundle = Bundle.resources else {
            return nil
        }
        return UIImage(named: imageName, in: resourcesBundle, compatibleWith: nil)
    }
    
}

extension String {
    
    static func localizedString(_ localizationKey: String) -> String {
        guard let resourcesBundle = Bundle.resources else {
            return localizationKey
        }
        return NSLocalizedString(localizationKey, tableName: nil, bundle: resourcesBundle, value: "", comment: "")
    }
    
}
