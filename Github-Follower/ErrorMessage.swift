//
//  ErrorMessage.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 27.02.2025.
//

import Foundation

enum GFError : String , Error {
    case invalideUsername    = "This username created an invalid request. Please try again."
    case unableToComplete    = "Unable to complete your request. Please check your internet connection"
    case invalidResponse     = "Invalid response from the server. Please try again"
    case invalidData         = "The data received from the server was invalid. Please try again."
    case uanbleToFavorite    = "There was an error fovoriting this user. Please try again."
    case alreadyInFavorites  = "You've already favvorited this user. You must REALLY like them!"
}
