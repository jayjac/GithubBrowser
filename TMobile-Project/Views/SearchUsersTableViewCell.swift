//
//  SearchUsersTableViewCell.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import SDWebImage

class SearchUsersTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var repoCountLabel: UILabel!
    private var gitHubUserViewModel: GitHubUserViewModel!
    
    func setup(with userViewModel: GitHubUserViewModel) {
        self.gitHubUserViewModel = userViewModel
        updateUI()
    }
    
    private func updateUI() {
        let user = gitHubUserViewModel.gitHubUser
        if let urlString = user.avatarUrl {
            let url = URL(string: urlString)
            avatarImageView.sd_setImage(with: url, completed: nil)
        }
        
        userNameLabel.text = user.login
    }

}
