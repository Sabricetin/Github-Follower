//
//  FollowerListVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 21.02.2025.
//

import UIKit

class FollowerListVC: UIViewController {

    
    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
