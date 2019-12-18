//
//  SearchManager.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class UserSearchManager: SearchManager {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var userSearchRequest: UserSearchRequest?
    private let tableView: UITableView
    
    private(set) static var gitHubUsersViewModelArray: [GitHubUserViewModel] = [GitHubUserViewModel]()
    static let hasMoreResults: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    required init(searchBar: UISearchBar, tableView: UITableView) {
        self.tableView = tableView
        super.init(searchBar: searchBar)
    }
    

    override func performSearchRequest(with text: String) {
        userSearchRequest = UserSearchRequest(userName: text, delegate: self)
        userSearchRequest?.search()
    }
    
    func searchNextPage() {
        userSearchRequest?.search(nextPage: true)
    }

}

extension UserSearchManager: UserSearchRequestDelegate {
    
    func userSearchRequestDidComplete(with users: [GitHubUser], for page: Int) {
        UserSearchManager.hasMoreResults.accept(!users.isEmpty)
        let newUserViewModels: [GitHubUserViewModel] = users.map({ (user) -> GitHubUserViewModel in
            GitHubUserViewModel(gitHubUser: user)
        })
        if page > 1 {
            let oldUserViewModels: [GitHubUserViewModel] = UserSearchManager.gitHubUsersViewModelArray
            UserSearchManager.gitHubUsersViewModelArray = oldUserViewModels + newUserViewModels
        } else {
            UserSearchManager.gitHubUsersViewModelArray = newUserViewModels
        }
        tableView.reloadData()
    }
}
