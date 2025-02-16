//
//  AuthManager.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

final class AuthManager {
    // MARK: - Shared
    static let shared = AuthManager()
    
    // MARK: - Struct
    struct Constants {
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
        static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
    }
    
    // MARK: - Properties
    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize?"
        let scope = "user-top-read"
        let redirectURI = "https://github.com/AmrHTolba"
        let string = baseUrl + "response_type=code&client_id=\(Constants.clientID)&scope=\(scope)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
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
    
    // MARK: - Methods
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let request = createTokenRequest(code: code) else {
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("JSON is \(json)")
            } catch {
                print("Failed to parse JSON \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    private func createTokenRequest(code: String) -> URLRequest? {
        guard let url = URL(string: Constants.tokenAPIUrl) else {
            print("Couldn't get URL")
            return nil
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://github.com/AmrHTolba"),
        ]
        
        let basicToken  = Constants.clientID + ":" + Constants.clientSecret
        guard let base64String = basicToken.data(using: .utf8)?.base64EncodedString() else {
            print("Failed to get Base64 string")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody   = components.query?.data(using: .utf8)
        return request
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cashToken() {
        
    }
    
    
}
