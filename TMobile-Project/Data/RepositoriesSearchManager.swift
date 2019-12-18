//
//  RepositoriesSearchManager.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RepositoriesSearchManager: SearchManager {
    
    private let tableView: UITableView
    private var userRepoSearchRequest: UserRepoSearchRequest?
    private let gitHubUserViewModel: GitHubUserViewModel
    private(set) var repos: [GitHubRepo] = [GitHubRepo]()
    
    
    init(searchBar: UISearchBar,
         tableView: UITableView,
         gitHubUserViewModel: GitHubUserViewModel
        ) {
        self.tableView = tableView
        self.gitHubUserViewModel = gitHubUserViewModel
        super.init(searchBar: searchBar)
    }
    
    override func performSearchRequest(with text: String) {
        userRepoSearchRequest = UserRepoSearchRequest(text: text, user: gitHubUserViewModel, delegate: self)
        userRepoSearchRequest?.search()
    }
    
}


extension RepositoriesSearchManager: UserRepoSearchRequestDelegate {
    func userRepoDidUpdateRepo(_ repos: [GitHubRepo]) {
        self.repos = repos
        tableView.reloadData()
    }
}
