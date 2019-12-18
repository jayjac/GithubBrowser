//
//  GitHubSearchTableViewDataSource.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit

class GitHubSearchTableViewDataSource: NSObject,  UITableViewDataSource {
    
    private let reuseIdentifier: String = "UserSearchTableViewCell"
    private let loadMoreReuseIdentifier: String = "LoadMoreTableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserSearchManager.gitHubUsersViewModelArray.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == UserSearchManager.gitHubUsersViewModelArray.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: loadMoreReuseIdentifier)
            return cell!
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SearchUsersTableViewCell else { fatalError() }
        let viewModel = UserSearchManager.gitHubUsersViewModelArray[row]
        cell.setup(with: viewModel)
        viewModel.fetchRepos()
        return cell
    }
}
