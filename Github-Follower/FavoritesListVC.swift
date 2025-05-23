//
//  FavoritesListVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 18.02.2025.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC  {
    
    let tableView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title                = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles  = true
        
    }
    func configureTableView() {
        view.addSubview(tableView)
        
        //View.frame = view.bounds
        tableView.frame = view.bounds
        
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
              
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlertOnMainThread(title: "Something went wrong ", message: error.rawValue, buttonTitle: "OK")
                }
            }
        
        }
    }
    
    func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptStateView(with: "No Favorites?\nAdd one the follower scren", in: self.view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
                
            }
        }
        
        
    }
}


extension FavoritesListVC: UITableViewDataSource , UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favorite = favorites[indexPath.row]
        let destVC  = FollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let  self else { return }
            guard let  error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if self.favorites.isEmpty {
                    self.showEmptStateView(with: "No Favorites?\nAdd one the follower scren", in: self.view)

                }
                return
                
                
            }
            DispatchQueue.main.async {
                self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")

            }
        }
    }
}
