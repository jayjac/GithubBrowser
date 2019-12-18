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

class SearchManager {
    
    private let searchBar: UISearchBar
    private let disposeBag: DisposeBag = DisposeBag()
    private var userSearchRequest: UserSearchRequest?
    private let tableView: UITableView
    
    static let gitHubUsers: BehaviorRelay<[GitHubUserViewModel]> = BehaviorRelay(value: [GitHubUserViewModel]())
    static let hasMoreResults: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    init(searchBar: UISearchBar, tableView: UITableView) {
        self.tableView = tableView
        self.searchBar = searchBar
        listenToTextChanges()
    }
    
    
    private func listenToTextChanges() {
        searchBar.rx.text.asDriver().throttle(.milliseconds(1000)).distinctUntilChanged().drive(onNext: { [weak self] (text) in
            guard let strongSelf = self, let text = text else { return }
            strongSelf.performSearchRequest(with: text)
        }).disposed(by: disposeBag)
    }
    
    private func performSearchRequest(with text: String) {
        SearchManager.hasMoreResults.accept(true)
        userSearchRequest = UserSearchRequest(userName: text, delegate: self)
        userSearchRequest?.search()
    }
    
    func searchNextPage() {
        userSearchRequest?.search(nextPage: true)
    }

}

extension SearchManager: UserSearchRequestDelegate {
    
    func userSearchRequestDidComplete(with users: [GitHubUser], for page: Int) {
        SearchManager.hasMoreResults.accept(!users.isEmpty)
        let newUserViewModels: [GitHubUserViewModel] = users.map({ (user) -> GitHubUserViewModel in
            GitHubUserViewModel(gitHubUser: user)
        })
        if page > 1 {
            let oldUserViewModels: [GitHubUserViewModel] = SearchManager.gitHubUsers.value
            SearchManager.gitHubUsers.accept(oldUserViewModels + newUserViewModels)
        } else {
            SearchManager.gitHubUsers.accept(newUserViewModels)
        }
        
        tableView.reloadData()
    }
}
