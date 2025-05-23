//
//  FollowerListVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 21.02.2025.
//

import UIKit



class FollowerListVC: GFDataLoadingVC   {

    enum Section { case main }
    
    var username : String!
    var followers: [Follower]           = []
    var filteredFollowers: [Follower]   = []
    var page                            = 1
    var hasMoreFollowers                = true
    var isSearching                     = false
    var isLoadingMoreFollowers          = false
    
    var collectionView: UICollectionView!
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearcController()
        configureViewController ()
        getFollowers(username: username, page: page)
        configureDataSource()
        updateData(on: followers)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if followers.isEmpty && !isLoadingMoreFollowers {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "person.slash")
            config.text = "No Followers"
            config.secondaryText = "This user has no followers. Go follow them!"
            contentUnavailableConfiguration = config
        } else if isSearching && filteredFollowers.isEmpty {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
            
        } else {
            contentUnavailableConfiguration = nil

        }
    }
    
    
    
    
    func configureViewController () {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func configureCollectionView() {  
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func configureSearcController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    
    func getFollowers(username: String , page: Int) {
        showLoadingView()
        isLoadingMoreFollowers   = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
                isLoadingMoreFollowers = false
                
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlertOnMainThread(title: "Bad Stuff HAppend ", message: gfError.rawValue, buttonTitle: "OK")
                    
                } else {
                    presentDefaultError()
                }
                isLoadingMoreFollowers  = false
                dismissLoadingView()
                
            }
        }
        
        
        
//        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//            
//            guard let self = self else {return}
//            dismissLoadingView()
//            switch result {
//            case.success(let followers):
//                self.updateUI(with: followers)
//
//            case.failure(let error):
//                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
//
//            }
//            self.isLoadingMoreFollowers = false
//        }
    }
    
    func updateUI(with followers: [Follower]) {
        
        
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        setNeedsUpdateContentUnavailableConfiguration()
        
        self.updateData(on: self.followers)
        
    }
    
    
    func configureDataSource () {
        dataSource = UICollectionViewDiffableDataSource<Section , Follower> (collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData (on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section , Follower> ()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot , animatingDifferences: true) }
        
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlertOnMainThread(title: "Something Went Wrong", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                
                dismissLoadingView()
            }
        }
        
//        NetworkManager.shared.getUserInfo(for: username) {[weak self]result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//            
//            switch result {
//            case  .success(let user):
//                self.addUserToFavorites(user: user)
//                
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.localizedDescription, buttonTitle:    "OK")
//            }
//        }
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self else {return}
            
            guard let error else {
                DispatchQueue.main.async {
                    self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully fovorited this user 🎊", buttonTitle: "Yep")
                }
                
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.localizedDescription, buttonTitle:    "OK")

            }
        }
        
    }
    
}


extension  FollowerListVC : UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
            
        if offsetY > contentHeight - height {
            guard hasMoreFollowers , !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


extension FollowerListVC : UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty  else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
        setNeedsUpdateContentUnavailableConfiguration()
    }
  
    
}


extension FollowerListVC : UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        
        
        self.username = username
        title = username
        page = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
}
