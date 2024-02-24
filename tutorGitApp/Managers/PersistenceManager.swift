//
//  Persistence.swift
//  tutorGitApp
//
//  Created by mehdimagerramov on 15.02.2024.
//

import Foundation

enum PersistenceAction {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceAction, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favotites):
                var retrievedFavorites = favotites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(.unableToFavorite)
                        return
                    }
                    retrievedFavorites.append(favorite)
                    
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: retrievedFavorites))
                
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
