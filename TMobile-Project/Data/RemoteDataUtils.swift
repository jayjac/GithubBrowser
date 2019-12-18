//
//  RemoteDataFetcher.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation

protocol RemoteDataFetcherDelegate: class {
    func remoteDataIsAvailable()
}

class RemoteDataUtils {
    //https://api.github.com/users/tomasperezv/repos
    
    private static let USER_PROFILE_API_URL = "https://api.github.com/users"
    private static let USERS_SEARCH_API_URL = "https://api.github.com/search/users"
    
    static func searchURLFor(userName: String, page: Int = 1) -> URL? {
        guard var urlComponents = URLComponents(string: USERS_SEARCH_API_URL) else { return nil }
        let queryItem1: URLQueryItem = URLQueryItem(name: "q", value: "\(userName)+in:login")
        let queryItem2: URLQueryItem = URLQueryItem(name: "page", value: "\(page)")
        urlComponents.queryItems = [queryItem1, queryItem2]
        return urlComponents.url
    }
    
    static func userProfileInfoURL(of userName: String) -> URL? {
        let urlString = "\(USER_PROFILE_API_URL)/\(userName)"
        let url = URL(string: urlString)
        return url

    }
    
    static func reposURL(of userName: String) -> URL {
        let string = "\(USER_PROFILE_API_URL)/\(userName)/repos"
        guard let url = URL(string: string) else { fatalError() }
        return url
    }
    
    static func extractRepos(from data: Data) -> [GitHubRepo]? {
        let decoder = JSONDecoder()
        let repos = try? decoder.decode([GitHubRepo].self, from: data)
        return repos
    }
    
    static func extractSingleGitHubUser(from data: Data) -> GitHubUser? {
        let jsonDecoder = JSONDecoder()
        let user = try? jsonDecoder.decode(GitHubUser.self, from: data)
        return user
    }
    
    static func extractGitHubUsers(from data: Data) -> [GitHubUser]? {
        let jsonDecoder = JSONDecoder()
        let userResponse = try? jsonDecoder.decode(GitHubUserSearchReponse.self, from: data)
        return userResponse?.items
    }
}
