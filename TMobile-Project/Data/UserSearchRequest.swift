//
//  UserSearchRequest.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation

protocol UserSearchRequestDelegate: class {
    func userSearchRequestDidComplete(with users: [GitHubUser], for page: Int);
}

class UserSearchRequest {

    private unowned let delegate: UserSearchRequestDelegate
    private var urlSession: URLSession!
    private var page: Int = 1
    private var userName: String
    
    init(userName: String, delegate: UserSearchRequestDelegate,
         urlSession: URLSession = URLSession(configuration: .default)) {
        self.userName = userName
        self.delegate = delegate
        self.urlSession = urlSession
    }
    
    func search(nextPage: Bool = false) {
        guard userName.count > 1 else {
            delegate.userSearchRequestDidComplete(with: [GitHubUser](), for: 1)
            return
        }
        if nextPage {
            page += 1
        }
        guard let url = RemoteDataUtils.searchURLFor(userName: userName, page: page) else { return }
        let task = urlSession.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { return }
            guard let data = data, error == nil else { return }
            guard let gitHubUsers = RemoteDataUtils.extractGitHubUsers(from: data) else { return }
            
            DispatchQueue.main.async {
                strongSelf.delegate.userSearchRequestDidComplete(with: gitHubUsers, for: strongSelf.page)
            }
        }
        task.resume()
    }
}
