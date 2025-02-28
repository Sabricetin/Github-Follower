//
//  FollowerListVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 21.02.2025.
//

import UIKit

class FollowerListVC: UIViewController {

    
    var username : String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController ()
        getFollowers()
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController () {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPurple
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        
       
        
        let width                        = view.bounds.width
        let padding : CGFloat            = 12
        let minumumItemSpacing : CGFloat = 10
        let availabelWidth               = width - (padding * 2) - (minumumItemSpacing * 2)
        let itemWidth                    = availabelWidth / 3
        
        let flowLayout                   = UICollectionViewFlowLayout()
        flowLayout.sectionInset          = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize              = CGSize(width: itemWidth, height: itemWidth + 40)
        
        
        
        return flowLayout   
    }
    
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case.success(let followers):
                print(followers)


            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")

            }
        }
    }

}
