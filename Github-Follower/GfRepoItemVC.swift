//
//  GfRepoItemVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 9.03.2025.
//

import Foundation

protocol GFRepoITemVCDelegate : AnyObject {
    func didTapGithubProfile(for user : User)
    
}


class GfRepoItemVC: GFITemInfoVC {
    
    weak var delegate: GFRepoITemVCDelegate!
    
    init(user: User , delegate : GFRepoITemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(color: .systemPurple, title: "Github Profile", systemImageName: "person.fill")
        
    }
     
    override func actionButtonTapped () {
        
        delegate.didTapGithubProfile(for: user)
        
    }
    
}
