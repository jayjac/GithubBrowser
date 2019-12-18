//
//  UserProfileViewController.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit
import SDWebImage

class UserProfileViewController: UIViewController {
    

    var viewModel: GitHubUserViewModel!
    @IBOutlet var tableView: UITableView!
    private var tableViewDataSource: UserProfileTableViewDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableViewDataSource = UserProfileTableViewDataSource(viewModel: viewModel, tableView: tableView)
    }
    
    
    
    


}
