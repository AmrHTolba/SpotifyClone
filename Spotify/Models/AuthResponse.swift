//
//  AuthResponse.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 18/02/2025.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String?
    let scope: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken  = "access_token"
        case expiresIn    = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case tokenType    = "token_type"
    }
}
