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
    
    private static let API_URL = "https://api.github.com/search/users"
    
    static func searchURLFor(userName: String, page: Int = 1) -> URL? {
        guard var urlComponents = URLComponents(string: API_URL) else { return nil }
        let queryItem1: URLQueryItem = URLQueryItem(name: "q", value: "\(userName)+in:login")
        let queryItem2: URLQueryItem = URLQueryItem(name: "page", value: "\(page)")
        urlComponents.queryItems = [queryItem1, queryItem2]
        return urlComponents.url
    }
    
    static func extractGitHubUsers(from data: Data) -> [GitHubUser]? {
        let jsonDecoder = JSONDecoder()
        guard let userResponse = try? jsonDecoder.decode(GitHubUserReponse.self, from: data) else { return nil }
        return userResponse.items
    }
}
