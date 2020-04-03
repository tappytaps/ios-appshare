//
//  AppShareRequest.swift
//  AppShare
//
//  Created by Lukas Boura on 02/04/2020.
//

import UIKit
import LinkPresentation

public struct AppShareRequest {
    let link: String
    let text: String
    let subject: String
    
    var linkUrl: URL? { URL(string: link) }
    
    public init(link: String, text: String, subject: String) {
        self.link = link
        self.text = text
        self.subject = subject
    }
}

class AppShareRequestActivityItem: NSObject, UIActivityItemSource {
    
    let shareRequest: AppShareRequest
    
    init(shareRequest: AppShareRequest) {
        self.shareRequest = shareRequest
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return shareRequest.text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return shareRequest.text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return shareRequest.subject
    }
    
    @available(iOS 13, *)
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.originalURL = shareRequest.linkUrl
        return metadata
    }
    
}
