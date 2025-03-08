//
//  GFFollowerITemVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 9.03.2025.
//

import Foundation

class GFFollowerItemVC: GFITemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(bacgroundColor: .systemGreen, title: "Get Followers")
        
    }
    
}
