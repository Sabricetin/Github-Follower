//
//  FavoritesListVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 18.02.2025.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        
        }
        
    }
    


}
