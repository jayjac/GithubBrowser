//
//  SearchUsersTableViewCell.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/18/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class SearchUsersTableViewCell: UITableViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var repoCountLabel: UILabel!
    private var gitHubUserViewModel: GitHubUserViewModel!
    private var disposeBag: DisposeBag = DisposeBag()
    
    func setup(with userViewModel: GitHubUserViewModel) {
        self.gitHubUserViewModel = userViewModel
        listenToReposCountChanges()
        updateUI()
    }
    
    private func listenToReposCountChanges() {
        disposeBag = DisposeBag() // Cancels previous subscription
        gitHubUserViewModel.gitHubUser.asDriver().drive(onNext: { [weak self] _ in
            self?.updateReposCount()
        }).disposed(by: disposeBag)
    }
    
    private func updateUI() {
        let user = gitHubUserViewModel.gitHubUser.value
        avatarImageView.sd_setImage(with: user.avatarUrl, completed: nil)
        userNameLabel.text = user.login
        updateReposCount()
    }
    
    private func updateReposCount() {
        guard let repos = gitHubUserViewModel.gitHubUser.value.repos else {
            return
        }
        repoCountLabel.text = "Repos #: \(repos.count)"
    }
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        userNameLabel.text = ""
        repoCountLabel.text = "Repos #:"
    }

}
