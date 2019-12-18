//
//  GitHubDateFormatter.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation


class GitHubDateFormatter {
    
    class func formatDate(string: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormat.date(from: string) else { return "" }
        
        let dateFormat1 = DateFormatter()
        dateFormat1.dateStyle = .medium
        dateFormat1.timeStyle = .none
        
        return dateFormat1.string(from: date)
    }
}
