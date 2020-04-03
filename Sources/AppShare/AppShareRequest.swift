//
//  AppShareRequest.swift
//  AppShare
//
//  Created by Lukas Boura on 02/04/2020.
//

import Foundation

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
