//
//  UserProfileRepoSearchResultTableViewCell.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileRepoSearchResultTableViewCell: UITableViewCell {

    @IBOutlet var repoNameLabel: UILabel!
    @IBOutlet var forksLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    
    func setup(with repo: GitHubRepo) {
        repoNameLabel.text = repo.description
        forksLabel.text = "Forks: \(repo.forkCount)"
        starsLabel.text = "Stars: \(repo.starCount)"
    }

}
