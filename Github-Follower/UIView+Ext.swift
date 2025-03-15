//
//  UIView+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 14.03.2025.
//

import UIKit


extension UIView {
    
    func pintoEdges (of superview : UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
           topAnchor.constraint(equalTo: superview.topAnchor),
           leadingAnchor.constraint(equalTo: superview.leadingAnchor),
           trailingAnchor.constraint(equalTo: superview.trailingAnchor),
           bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            
        ])
    }
    
    func addSubsviews( views: UIView...) {
        for view in views { addSubview(view) }
    }
    
}
