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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchManager.gitHubUsers.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SearchUsersTableViewCell else { fatalError() }
        cell.setup(with: SearchManager.gitHubUsers.value[indexPath.row])
        return cell
    }
}
