//
//  GitHubUserViewModel.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class GitHubUserViewModel {
    
    let gitHubUser: BehaviorRelay<GitHubUser>
    //let repoCount: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
   
    private var userDataFetcher: UserDataRequest?
    
    
    init(gitHubUser: GitHubUser) {
        self.gitHubUser = BehaviorRelay(value: gitHubUser)
    }
    
    func fetchRepos() {
        guard gitHubUser.value.repos == nil else { return }
        userDataFetcher = UserDataRequest(delegate: self)
        userDataFetcher?.fetchRepoCount(of: gitHubUser.value)
    }
    
    func fetchUserInfo() {
        userDataFetcher = UserDataRequest(delegate: self)
        userDataFetcher?.fetchUserProfileInfo(of: gitHubUser.value)
    }
    
    
}


extension GitHubUserViewModel: UserDataFetcherDelegate {
    
    func userDataDidUpdateProfileInfo(of user: GitHubUser) {
        gitHubUser.accept(user)
    }
    
    func userDataDidUpdateRepos(of user: GitHubUser, repos: [GitHubRepo]) {
        gitHubUser.accept(user)
    }
    
    

}
