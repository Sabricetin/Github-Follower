//
//  User.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 24.02.2025.
//

import Foundation

struct User: Codable {
    var login : String
    var avatarURl : String
    var name: String?
    var location : String?
    var bio: String?
    var publicRepos : Int
    var publicGists : Int
    var htmlUrl : String
    var following: Int
    var followers: Int
    var createdAt: String
    
}
