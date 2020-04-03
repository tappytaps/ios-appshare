//
//  AppShareController.swift
//  AppShare
//
//  Created by Lukas Boura on 31/03/2020.
//

import UIKit

public struct AppShareController {
    
    let request: AppShareRequest
    let presentationContext: UIViewController
    
    public init(request: AppShareRequest, presentationContext: UIViewController) {
        self.request = request
        self.presentationContext = presentationContext
    }
    
    public func show() {
        let shareController = AppShareViewController(request: request)
        shareController.extendedLayoutIncludesOpaqueBars = true
        
        let navigationController = UINavigationController(rootViewController: shareController)
        navigationController.modalPresentationStyle = .formSheet
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        navigationController.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            navigationController.navigationBar.barTintColor = .systemBackground
        } else {
            navigationController.navigationBar.barTintColor = .white
        }
        
        presentationContext.present(navigationController, animated: true)
    }
    
}
