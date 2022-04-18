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
        PosterTableViewCell.registerCell(into: tableView)
        LoaderTableViewCell.registerCell(into: tableView)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Movies"
        navigationItem.searchController = searchController
        presenter.setupController()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.total
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let factory = PosterTableViewCellFactory(tableView: tableView, indexPath: indexPath)
        if presenter.shouldShowLoadingCell(for: indexPath) {
            return factory.loaderTableViewCell()
        } else {
            return factory.posterTableViewCell(with: presenter.elements[indexPath.row])
        }
    }
}

// MARK: - Table view data source Prefetching
extension SearchMovieTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: presenter.shouldShowLoadingCell(for:)) {
            presenter.fetchData(with: nil)
        }
    }
}

extension SearchMovieTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              text != presenter.currentWord,
              !text.isEmpty else {
            return
        }
        presenter.fetchData(with: text)
  }
}
