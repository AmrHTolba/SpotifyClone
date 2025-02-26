//
//  Artist.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let externalUrls: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, type
        case externalUrls = "external_urls"
    }
}

