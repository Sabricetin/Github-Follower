//
//  NetworkManager.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 26.02.2025.
//

import UIKit

class NetworkManager     {
   static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    
    let cache = NSCache<NSString , UIImage>()
    
    private init() { }
    
    func getFollowers(for username : String , page: Int , completed: @escaping (Result<[Follower] , GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalideUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , response , error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                
                    completed(.failure(.invalidData))
                
                
            }
            
        }
        task.resume()
    }
    
    
    
   
    func getUserInfo(for username : String , completed: @escaping (Result<User, GFError>) -> Void) {
 
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalideUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , response , error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                print("Received JSON: \(String(data: data, encoding: .utf8) ?? "Invalid Data")")

                let decoder = JSONDecoder()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let User = try decoder.decode(User.self, from: data)
                completed(.success(User))
                
            } catch {
                print("Decoding error: \(error.localizedDescription)")

                    completed(.failure(.invalidData))
                
                
            }
            
        }
        task.resume()
    }

    
}
