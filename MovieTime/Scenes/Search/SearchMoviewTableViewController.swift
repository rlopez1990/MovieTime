//
//  SearchMoviewTableViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 15/04/22.
//

import UIKit

final class SearchMoviewTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)

        
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Movies"
        navigationItem.searchController = searchController
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension SearchMoviewTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    //let searchBar = searchController.searchBar
   // let category = Candy.Category(rawValue:
   //   searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    //filterContentForSearchText(searchBar.text!, category: category)
  }
}
