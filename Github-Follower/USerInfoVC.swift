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
        
        print(username!)
       
    }
    
    @objc func dismisVC() {
        
        dismiss(animated: true)
        
    }

}
