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
    let avatarUrl: URL?
    let reposUrl: URL?
    var repos: [GitHubRepo]?
    var followers: Int?
    var following: Int?
    var location: String?
    var bio: String?
    var email: String?
    var joinDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case bio
        case location
        case email
        case followers
        case following
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
        case joinDate = "created_at"
    }
    
    func updateRepos(_ repos: [GitHubRepo]) {
        self.repos = repos
    }

    
    func refreshWith(user: GitHubUser) {
        followers = user.followers
        following = user.following
        bio = user.bio
        location = user.location
        email = user.email
        joinDate = user.joinDate
    }
    
}

struct GitHubUserSearchReponse: Codable {
    let items: [GitHubUser]
}

