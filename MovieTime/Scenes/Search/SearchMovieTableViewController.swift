//
//  SearchMoviewTableViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 15/04/22.
//

import UIKit

final class SearchMovieTableViewController: UITableViewController, ListMoviesDisplayable {

    let searchController = UISearchController(searchResultsController: nil)
    internal var loader: LoadingViewProtocol = LoadingView()
    lazy var presenter: SearchMoviePresenter = SearchMoviePresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Movies"
        navigationItem.searchController = searchController
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.total
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let factory = PosterTableViewCellFactory(tableView: tableView, indexPath: indexPath)
        return factory.posterTableViewCell(with: presenter.elements[indexPath.row])
    }
}

// MARK: - Table view data source Prefetching
extension SearchMovieTableViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
      if indexPaths.contains(where: presenter.shouldShowLoadingCell(for:)) {
          //presenter.fetchData
      }
  }
}

extension SearchMovieTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    //let searchBar = searchController.searchBar
   // let category = Candy.Category(rawValue:
   //   searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    //filterContentForSearchText(searchBar.text!, category: category)
  }
}
