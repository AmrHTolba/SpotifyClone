//
//  AuthManager.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var expiresIn: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        false
    }
}
