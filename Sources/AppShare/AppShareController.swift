//
//  AppShareController.swift
//  AppShare
//
//  Created by Lukas Boura on 31/03/2020.
//

import UIKit

public struct AppShareController {
    
    // MARK: Dependencies
    
    private let request: AppShareRequest
    private let configuration: AppShareConfiguration
    private let presentationContext: UIViewController
    
    public init(request: AppShareRequest, configuration: AppShareConfiguration = .default, presentationContext: UIViewController) {
        self.request = request
        self.configuration = configuration
        self.presentationContext = presentationContext
    }
    
    public func show() {
        let shareController = AppShareViewController(request: request, configuration: configuration)
        shareController.extendedLayoutIncludesOpaqueBars = true
        
        let navigationController = UINavigationController(rootViewController: shareController)
        navigationController.modalPresentationStyle = .formSheet
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            navigationController.navigationBar.barTintColor = .systemBackground
        } else {
            navigationController.navigationBar.barTintColor = .white
        }
        
        if configuration.hasTitle {
            if #available(iOS 11.0, *) {
                navigationController.navigationBar.prefersLargeTitles = true
            }
        }
        
        presentationContext.present(navigationController, animated: true)
    }
    
}
