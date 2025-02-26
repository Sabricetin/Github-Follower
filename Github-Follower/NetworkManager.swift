//
//  NetworkManager.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 26.02.2025.
//

import Foundation

class NetworkManager     {
    let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() { }
    
    func getFollowers(for username : String , page: Int , completed: @escaping ([Follower]? , String?) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil , "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , response . error in
            
        }
        task.resume()
    }
}
