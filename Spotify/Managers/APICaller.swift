//
//  APICaller.swift
//  Spotify
//
//  Created by Amr El-Fiqi on 13/02/2025.
//

import Foundation

final class APICaller {
    // MARK: - Shared
    static let shared = APICaller()
    
    private init() {}
    
    // MARK: - Constants
    private struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    // MARK: - Enum
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case decodingFailed
        case failedToGetData
    }
    
    // MARK: - Methods
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(url: URL(string: "\(Constants.baseAPIURL)/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(results)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }       
            }
            task.resume()
        }
    }
        
    private func createRequest(url: URL?, type: HTTPMethod ,completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidTOken { token in
            guard let apiURL = url else { return }
            var request  = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}


