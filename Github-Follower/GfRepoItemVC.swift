//
//  GfRepoItemVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 9.03.2025.
//

import Foundation


class GfRepoItemVC: GFITemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(bacgroundColor: .systemPurple, title: "Github Profile")
        
    }
    
}
