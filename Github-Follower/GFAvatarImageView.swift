//
//  GFAvatarImageView.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 28.02.2025.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder
    
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
    
    func downloadImage(fromURL url: String) {
        
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
        
//        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
//            guard let self = self else {return }
//            DispatchQueue.main.async { self.image = image }
//        }
    }
    
}
