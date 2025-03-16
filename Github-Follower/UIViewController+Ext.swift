//
//  UIViewController+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 24.02.2025.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String , message: String , buttonTitle: String) {
        
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC , animated: true)
        }
        
    }

    func presentDefaultError() {
        
            let alertVC = GFAlertVC(alertTitle: "Something Went Wrong",
                                    message: "We were unable to complete your task at this time . Please try again .",
                                    buttonTitle: "OK")
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC , animated: true)
        
        
    }
    
    
    func presentSafariVC(with url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC , animated: true)
        
    }
    
}

