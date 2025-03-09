//
//  String+Ext.swift
//  Github-Follower
//
//  Created by Sabri Çetin on 10.03.2025.
//

import Foundation

extension String {
    
    func convertToDate() -> Date?  {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.timeZone = .current
        
        
        return dateFormatter.date(from: self)
        
    }
    
    func convertToDisplayFormat() -> String {
        
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
        
    }
}
