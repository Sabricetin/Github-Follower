//
//  FollowerListVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 21.02.2025.
//

import UIKit

class FollowerListVC: UIViewController {

    enum Section { case main }
    
    var username : String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var collectionView: UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController ()
        getFollowers(username: username, page: page)
        configureDataSource()
        updateData()
        
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
   
    
    
    func getFollowers(username: String , page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            
            guard let self = self else {return}
            dismissLoadingView()
            switch result {
            case.success(let followers):
                
                
                
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't any followers. Go follow them.😊"
                    DispatchQueue.main.async { self.showEmptStateView(with: message, in: self.view) }
                    return
                    
                }
                self.updateData()


            case.failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")

            }
        }
    }
    
    func configureDataSource () {
        dataSource = UICollectionViewDiffableDataSource<Section , Follower> (collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
//            cell.usernameLabel
            return cell
        })
    }
    
    func updateData () {
        var snapshot = NSDiffableDataSourceSnapshot<Section , Follower> ()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot , animatingDifferences: true) }
        
    }

    
}


extension  FollowerListVC : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
            
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
}
