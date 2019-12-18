//
//  UserDataFetcher.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation

protocol UserDataFetcherDelegate: class {
    func userDataDidUpdateProfileInfo(of user: GitHubUser)
    func userDataDidUpdateRepos(of user: GitHubUser, repos: [GitHubRepo])
}

class UserDataRequest {
    
    private weak var delegate: UserDataFetcherDelegate?
    private let urlSession: URLSession
    
    init(delegate: UserDataFetcherDelegate,
         urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
        self.delegate = delegate
    }
    
    func fetchUserProfileInfo(of user: GitHubUser) {
        guard let url = RemoteDataUtils.userProfileInfoURL(of: user.login) else { return }
        let task = urlSession.dataTask(with: url) {
            [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { return }
            guard let data = data, error == nil else { return }
            guard let user = RemoteDataUtils.extractSingleGitHubUser(from: data) else { return }
            
            DispatchQueue.main.async {
                user.refreshWith(user: user)
                strongSelf.delegate?.userDataDidUpdateProfileInfo(of: user)
            }
        }
        task.resume()
    }
    
    func fetchRepoCount(of user: GitHubUser) {
        guard let url = user.reposUrl else { return }
        let task = urlSession.dataTask(with: url) {
            [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { return }
            guard let data = data, error == nil else { return }
            guard let repos = RemoteDataUtils.extractRepos(from: data) else {  return }
            DispatchQueue.main.async {
                user.updateRepos(repos)
                strongSelf.delegate?.userDataDidUpdateRepos(of: user, repos: repos)
            }
        }
        task.resume()
    }
}
