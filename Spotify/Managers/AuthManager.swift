//
//  AuthManager.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    static var clientID: String {
        guard let id = Bundle.main.object(forInfoDictionaryKey: "DevClientID") as? String else {
            fatalError("Couldn't get clientID")
        }
        return id
    }
    
    static var clientSecret: String {
        guard let id = Bundle.main.object(forInfoDictionaryKey: "DevClientSecret") as? String else {
            fatalError("Couldn't get clientID")
        }
        return id
    }
    
    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize?"
        let scope = "user-top-read"
        let redirectURI = "https://github.com/AmrHTolba"
        let string = baseUrl + "response_type=code&client_id=\(AuthManager.clientID)&scope=\(scope)&redirect_uri=\(redirectURI)"
        return URL(string: string)
        
    }
    
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
