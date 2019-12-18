//
//  ViewController.swift
//  TMobile-Project
//
//  Created by Jay Jac on 12/17/19.
//  Copyright © 2019 Jay Jac. All rights reserved.
//

import UIKit


class GitHubSearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    private var searchManager: SearchManager!
    private let segueIdentifier: String = "ShowUserProfileSegue"
    @IBOutlet var tableView: UITableView!
    private let dataSource: UITableViewDataSource = GitHubSearchTableViewDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager = SearchManager(searchBar: searchBar, tableView: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier else {
            return
        }
        guard let destinationVC = segue.destination as? UserProfileViewController else {
            return
        }
        guard let viewModel = sender as? GitHubUserViewModel else { return }
        destinationVC.viewModel = viewModel
    }

}

extension GitHubSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: segueIdentifier, sender: SearchManager.gitHubUsers.value[indexPath.row])
    }
}

