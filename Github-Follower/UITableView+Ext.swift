//
//  UITableView+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 15.03.2025.
//

import UIKit


extension UITableView {
    
    func reloadDataOnMainThread() {
        
        DispatchQueue.main.async { self.reloadData()}
        
    }
    
    func removeExcessCells() {
        
        tableFooterView = UIView(frame: .zero)
    }
}
