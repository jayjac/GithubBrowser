//
//  UserProfileTableViewDataSource.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileTableViewDataSource: NSObject, UITableViewDataSource {
    
    private let topCellIdentifier: String =  "TopCell"
    private let repoCellIdentifier: String = "RepoCell"
    private let gitHubUserViewModel: GitHubUserViewModel
    private let tableView: UITableView
    private let disposeBag = DisposeBag()
    private var repoSearchManager: RepositoriesSearchManager?
    
    init(viewModel: GitHubUserViewModel,
         tableView: UITableView) {
        self.tableView = tableView
        self.gitHubUserViewModel = viewModel
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        listenToUserChanges()
        viewModel.fetchUserInfo()
    }
    
    private func setupRepoSearchManager(with searchBar: UISearchBar) {
        if repoSearchManager == nil {
            repoSearchManager = RepositoriesSearchManager(searchBar: searchBar, tableView: tableView, gitHubUserViewModel: gitHubUserViewModel)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: topCellIdentifier) as? UserProfileTopTableViewCell else {
                fatalError()
            }
            cell.setup(with: gitHubUserViewModel)
            setupRepoSearchManager(with: cell.searchBar)
            return cell
        }
        
        // Repo cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: repoCellIdentifier) as? UserProfileRepoSearchResultTableViewCell, let searchManager = repoSearchManager else {
            fatalError()
        }
        let repo = searchManager.repos[row - 1]
        cell.setup(with: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let repoSearchManager = repoSearchManager else {
            return 1
        }
        return 1 + repoSearchManager.repos.count
        
    }
    
    func listenToUserChanges() {
        gitHubUserViewModel.gitHubUser.asDriver().drive(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

}

extension UserProfileTableViewDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        guard row > 0, let searchManager = repoSearchManager else {
            return
        }
        let repo = searchManager.repos[row - 1]
        guard let url = repo.htmlUrl else { return }
        let application = UIApplication.shared
        guard application.canOpenURL(url) else { return }
        application.open(url)
    }
}
