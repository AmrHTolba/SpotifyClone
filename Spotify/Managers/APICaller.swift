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
    
    // MARK: - Methods
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
    }
    
}
