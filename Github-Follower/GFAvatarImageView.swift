//
//  GFAvatarImageView.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 28.02.2025.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder-dark")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
