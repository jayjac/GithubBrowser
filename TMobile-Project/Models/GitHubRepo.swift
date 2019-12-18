//
//  GitHubRepo.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation


struct GitHubRepo: Codable {
    
    let description: String?
    let starCount: Int
    let forkCount: Int
    let htmlUrl: URL?
    
    
    enum CodingKeys: String, CodingKey {
        case description
        case starCount = "stargazers_count"
        case forkCount = "forks_count"
        case htmlUrl = "html_url"
    }
    
}
