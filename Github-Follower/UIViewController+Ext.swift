//
//  UIViewController+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 24.02.2025.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String , message: String , buttonTitle: String) {
        
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC , animated: true)
        }
        
    }
}
