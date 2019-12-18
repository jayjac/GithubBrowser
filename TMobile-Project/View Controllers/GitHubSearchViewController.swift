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
    private var searchManager: UserSearchManager!
    private let segueIdentifier: String = "ShowUserProfileSegue"
    @IBOutlet var tableView: UITableView!
    private let dataSource: UITableViewDataSource = GitHubSearchTableViewDataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager = UserSearchManager(searchBar: searchBar, tableView: tableView)
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
        performSegue(withIdentifier: segueIdentifier, sender: UserSearchManager.gitHubUsersViewModelArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        if row == UserSearchManager.gitHubUsersViewModelArray.count {
            return 30.0
        }
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row //SearchManager.gitHubUsersViewModelArray.count
        if row > 0 && row == UserSearchManager.gitHubUsersViewModelArray.count && UserSearchManager.hasMoreResults.value {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.searchManager.searchNextPage()
            }
            
        }
        
    }
}

