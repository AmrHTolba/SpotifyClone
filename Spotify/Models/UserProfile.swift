//
//  UserProfile.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

struct UserProfile: Codable {
    let country, displayName, email: String
    let explicitContent: [String: Bool]
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let product: String

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case id, images, product
        }
}


