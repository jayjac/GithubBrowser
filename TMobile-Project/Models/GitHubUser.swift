//
//  File.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation


class GitHubUser: Codable {
    
    let id: Int
    let login: String
    let avatarUrl: String?
    let reposUrl: String?
    var repoCount: Int?
    let followersUrl: String?
    let followingUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
    }
    
}

struct GitHubUserReponse: Codable {
    let items: [GitHubUser]
}
