//
//  USerInfoVC.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 6.03.2025.
//

import UIKit

class USerInfoVC: UIViewController {
    
    var username : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUSerInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user ):
                print(user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Smothing went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
       
    }
    
    @objc func dismisVC() {
        
        dismiss(animated: true)
        
    }

}
