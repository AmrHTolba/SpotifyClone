//
//  FeaturedPlayListResponse.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 26/02/2025.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let message: String
    let playists: PlaylistResponse
    
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

struct Playlist: Codable {
    let description: String
    let externalUrls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case description, id, images, name, owner
        case externalUrls = "external_urls"
    }
}

struct Owner: Codable {
    let displayName: String
    let externalUrls: [String: String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case displayName, id
        case externalUrls = "external_urls"
    }
}
