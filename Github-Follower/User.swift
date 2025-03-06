//
//  User.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 24.02.2025.
//

import Foundation

struct User: Codable {
    let login : String
    let avatarURl : String
    var name: String?
    var location : String?
    var bio: String?
    let publicRepos : Int
    let publicGists : Int
    let htmlUrl : String
    let following: Int
    let followers: Int
    let createdAt: String
    
}

struct UserDetails : Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type, userViewType: String?
    let siteAdmin: Bool?
}
