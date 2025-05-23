//
//  SFSymbols.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 7.03.2025.
//

import Foundation
import UIKit


enum SFSymbols   {
    static let location                 = UIImage(systemName: "mappin.and.ellipse")
    static let repos                    = UIImage(systemName: "folder.fill")
    static let gists                    = UIImage(systemName: "text.alignleft")
    static let followers                = UIImage(systemName: "heart.square.fill")
    static let following                = UIImage(systemName: "person.2.fill")
}

            
enum Images {
                
    static let placeholder              =  UIImage(resource: .avatarPlaceholderDark)
    static let emptStateLogo            =  UIImage(resource: .emptyStateLogoDark)
    static let ghLogo                   =  UIImage(resource: .ghLogo)
}


enum ScreenSize {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let maxLength                = max(ScreenSize.width, ScreenSize.height)
    static let minLength                = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
