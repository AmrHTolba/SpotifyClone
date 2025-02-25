//
//  UserProfile.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

struct UserProfile: Codable {
    let country, displayName, email: String
    let explicitContent: [String: Int]
    let externalUrls: [String: Int]
    //let followers: [String: Codable?]
    let id: String
    let images: [UserImage]
    let product: String

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        //case followers
        case id, images, product
        }
}

struct UserImage: Codable {
    let url: String
    let height, width: Int
}
