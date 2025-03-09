//
//  Data+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 10.03.2025.
//

import Foundation
extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
        
    }
    
 
    
}
