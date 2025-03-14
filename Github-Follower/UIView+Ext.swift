//
//  UIView+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 14.03.2025.
//

import UIKit


extension UIView {
    
    func addSubsviews( views: UIView...) {
        for view in views { addSubview(view) }
    }
    
}
