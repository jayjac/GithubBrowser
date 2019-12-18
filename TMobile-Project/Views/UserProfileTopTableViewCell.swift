//
//  UserProfileTopTableViewCell.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit


class UserProfileTopTableViewCell: UITableViewCell {

    @IBOutlet var userAvatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var joinDateLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet var followingLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    

    
    func setup(with gitHubUserViewModel: GitHubUserViewModel) {
        let user = gitHubUserViewModel.gitHubUser.value
        resetUI()
        userAvatarImageView.sd_setImage(with: user.avatarUrl, completed: nil)
        userNameLabel.text = user.login
        locationLabel.text = user.location
        bioLabel.text = user.bio
        emailLabel.text = user.email
        if let followers = user.followers {
            followersLabel.text = "\(followers)"
        }
        if let following = user.following {
            followingLabel.text = "\(following)"
        }
        if let string = user.joinDate {
            joinDateLabel.text = GitHubDateFormatter.formatDate(string: string)
        }
        
    }
    
    private func resetUI() {
        joinDateLabel.text = ""
        followingLabel.text = "0"
        followersLabel.text = "0"
        userAvatarImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        return
    }

}
