//
//  UserRepoSearchRequest.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation


protocol UserRepoSearchRequestDelegate: class {
    func userRepoDidUpdateRepo(_ repos: [GitHubRepo])
}

class UserRepoSearchRequest {
    
    weak var delegate: UserRepoSearchRequestDelegate?
    private let text: String
    private let user: GitHubUser
    private let urlSession: URLSession
    
    init(text: String,
         user: GitHubUserViewModel,
         delegate: UserRepoSearchRequestDelegate,
         urlSession: URLSession = URLSession(configuration: .default)) {
        self.user = user.gitHubUser.value
        self.urlSession = urlSession
        self.text = text
        self.delegate = delegate
    }
    
    func search() {
        let url = RemoteDataUtils.reposURL(of: user.login)
        let task = urlSession.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { return }
            guard let data = data, error == nil else { return }
            guard let repos = RemoteDataUtils.extractRepos(from: data) else { return }
            
            DispatchQueue.main.async {
                strongSelf.delegate?.userRepoDidUpdateRepo(repos)
            }
        }
        task.resume()
    }
}
