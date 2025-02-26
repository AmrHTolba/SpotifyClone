//
//  NewRealeses.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 26/02/2025.
//

import Foundation


struct NewReleases: Codable {
    let albums: [AlbumsResponse]
    
    enum CodingKeys: String, CodingKey {
        case albums
    }
}

struct AlbumsResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let id: String
    let images: [APIImage]
    let releaseDate: String
    let totalTracks: Int
    
    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
        case artists, id, images
        
    }
}
