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
    
    // MARK: - Properties
    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize?"
        let params = [
            "response_type=code",
            "client_id=\(Constants.clientID)",
            "scope=\(Constants.scope)",
            "redirect_uri=\(Constants.redirectURI)",
            "show_dialog=TRUE"
        ].joined(separator: "&")
        return URL(string: baseUrl + params)
        
    }
    
    private init() {}
    
    var isSignedIn: Bool {
        accessToken != nil
    }
    
    private var accessToken: String? {
        UserDefaults.standard.string(forKey: "accessToken")
    }
    
    private var refreshToken: String? {
        UserDefaults.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirationDate: Date? {
        UserDefaults.standard.object(forKey: "expiration") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        return Date().addingTimeInterval(1) >= expirationDate
    }
    
    // MARK: - Methods
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        requestToken(grantType: "authorization_code",code: code, completion: completion)
    }
    
    public func refreshAccessToken(completion: @escaping (Bool) -> Void) {
//        guard shouldRefreshToken else {
//            completion(true)
//            return
//        }
        
        guard let refreshToken = self.refreshToken else {
            print("No refresh token available")
            completion(false)
            return
        }
        requestToken(grantType: "refresh_token", refreshToken: refreshToken, completion: completion)
    }
    
    private func requestToken(grantType: String, code: String? = nil, refreshToken: String? = nil,  completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: Constants.tokenAPIUrl) else {
            print("Couldn't get URL")
            return
        }
        
        var components = URLComponents()
            components.queryItems = [
                URLQueryItem(name: "grant_type", value: grantType)
            ]
        
        if let code = code {
                components.queryItems?.append(URLQueryItem(name: "code", value: code))
                components.queryItems?.append(URLQueryItem(name: "redirect_uri", value: Constants.redirectURI))
            }
        
        if let refreshToken = refreshToken {
                components.queryItems?.append(URLQueryItem(name: "refresh_token", value: refreshToken))
            }
        
        guard let request = createTokenRequest(url: url, body: components.query) else {
                completion(false)
                return
            }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }

                do {
                    let results = try JSONDecoder().decode(AuthResponse.self, from: data)
                    self?.cacheToken(result: results)
                    completion(true)
                } catch {
                    print("Failed to decode JSON: \(error.localizedDescription)")
                    completion(false)
                }
            }
            task.resume()
    }
    
    
    private func createTokenRequest(url: URL, body: String?) -> URLRequest? {
        let basicToken  = Constants.clientID + ":" + Constants.clientSecret
        guard let base64String = basicToken.data(using: .utf8)?.base64EncodedString() else {
            print("Failed to get Base64 string")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody   = body?.data(using: .utf8)
        return request
    }
    /*
    public func refreshAccessToken(completion: @escaping (Bool) -> Void ) {

        guard let refreshToken = self.refreshToken else {
            print("No refresh token found in UserDefaults")
            return
        }
        
        // Refresh
        guard let url = URL(string: Constants.tokenAPIUrl) else {
            print("Couldn't get URL")
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        let basicToken  = Constants.clientID + ":" + Constants.clientSecret
        guard let base64String = basicToken.data(using: .utf8)?.base64EncodedString() else {
            print("Failed to get Base64 string")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        request.httpBody   = components.query?.data(using: .utf8)

        // Refresh The Token
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let results = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: results)
                print("REFRESHED")
                completion(true)
            } catch {
                print("Failed to parse JSON \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    */
    private func cacheToken(result: AuthResponse) {
            UserDefaults.standard.set(result.accessToken, forKey: "accessToken")
            if let refreshToken = result.refreshToken {
                UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
            }
            UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expiration")
            UserDefaults.standard.synchronize()
        }
    
    
}


// MARK: - Constants
private struct Constants {
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
    static let redirectURI = "https://github.com/AmrHTolba"
    static let scope = "user-top-read%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-read%20user-read-email"
}
