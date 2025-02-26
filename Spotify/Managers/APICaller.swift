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
        getAPICall(urlCompletion: "/me", with: .GET, resultType: UserProfile.self, completion: completion)
    }
    
    public func getNewRlease(completion: @escaping (Result<NewReleases, Error>) -> Void) {
        getAPICall(urlCompletion: "/browse/new-releases?limit=50", with: .GET, resultType: NewReleases.self, completion: completion)
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistResponse, Error>) -> Void) {
        getAPICall(urlCompletion: "/browse/featured-playlists?limit=1", with: .GET, resultType: FeaturedPlaylistResponse.self, completion: completion)
    }
    
//    public func getrecommend(completion: @escaping (Result<RecommendedGenres, Error>) -> Void) {
//        createRequest(url: URL(string: "\(Constants.baseAPIURL)/recommendations/available-genre-seeds"), type: .GET) { baseRequest in
//            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.failedToGetData))
//                    return
//                }
//                
//                do {
//                    let results = try JSONSerialization.jsonObject(with: data)
//                    print(results)
//                } catch {
//                    completion(.failure(error))
//                }       
//            }
//            task.resume()
//        }
//    }
     
//    public func getNewReleases(completion: @escaping (Result<NewReleases, Error>) -> Void) {
//        createRequest(url: URL(string: "\(Constants.baseAPIURL)/browse/new-releases?limit=2"), type: .GET) { baseRequest in
//            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.failedToGetData))
//                    return
//                }
//                
//                do {
//                    let results = try JSONDecoder().decode(NewReleases.self, from: data)
//                    print(results)
//                    completion(.success(results))
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
    
    // MARK: - Generic Methods
    private func getAPICall<T: Decodable>(urlCompletion: String, with type: HTTPMethod,resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        createRequest(url: URL(string: Constants.baseAPIURL+urlCompletion), type: type) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil, !data.isEmpty else {
                    print("⚠️ Empty Response Data from Spotify API!")
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(resultType.self, from: data)
                    print(results)
                    completion(.success(results))
                } catch {
                    print("Decoding Failed")
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


