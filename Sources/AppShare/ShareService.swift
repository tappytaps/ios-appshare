//
//  ShareService.swift
//  AppShare
//
//  Created by Lukas Boura on 02/04/2020.
//

import UIKit
import FBSDKShareKit

enum ShareService: CaseIterable {
    
    case facebook
    case messenger
    case whatsApp
    case twitter
    case email
    case copyLink
    case more
    
    var imageName: String {
        switch self {
        case .facebook:  return "facebook"
        case .twitter:   return "twitter"
        case .whatsApp:  return "whatsapp"
        case .messenger: return "messenger"
        case .email:     return "message"
        case .copyLink:  return "copy"
        case .more:      return "more"
        }
    }
    
    var name: String {
        switch self {
        case .facebook:  return .localizedString("Facebook")
        case .twitter:   return .localizedString("Twitter")
        case .whatsApp:  return .localizedString("WhatsApp")
        case .messenger: return .localizedString("messenger")
        case .email:     return .localizedString("email")
        case .copyLink:  return .localizedString("copyLink")
        case .more:      return .localizedString("more")
        }
    }
    
    var urlScheme: String {
        switch self {
        case .facebook:  return "fbapi"
        case .twitter:   return "twitter"
        case .whatsApp:  return "whatsapp"
        case .messenger: return "fb-messenger"
        case .email:     return "mailto"
        case .copyLink, .more:
            return ""
        }
    }
    
    func share(_ request: AppShareRequest, from viewController: UIViewController) {
        
        func open(url: String) {
            guard let url = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "") else {
                return
            }
            UIApplication.shared.open(url)
        }
        
        switch self {
        case .facebook:
            guard let url = request.linkUrl else {
                return
            }
            let content = ShareLinkContent()
            content.contentURL = url
            content.quote = request.text
            
            ShareDialog(fromViewController: viewController, content: content, delegate: nil).show()
        case .twitter:
            open(url: "\(urlScheme)://post?message=\(request.text)")
        case .whatsApp:
            open(url: "\(urlScheme)://send?text=\(request.text)")
        case .messenger:
            open(url: "\(urlScheme)://share?link=\(request.link)")
        case .email:
            open(url: "\(urlScheme):?subject=\(request.subject)&body=\(request.text)")
        case .copyLink:
            UIPasteboard.general.string = request.link
        case .more:
            let activityController = UIActivityViewController(
                activityItems: [request.text],
                applicationActivities: nil
            )
            viewController.present(activityController, animated: true)
        }
        
    }
    
    var isAvailable: Bool {
        if self == .copyLink || self == .more {
            return true
        }
        guard let testUrl = URL(string: "\(urlScheme)://") else {
            return false
        }
        return UIApplication.shared.canOpenURL(testUrl)
    }
    
}
