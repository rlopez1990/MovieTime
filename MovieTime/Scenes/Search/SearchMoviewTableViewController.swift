//
//  SearchMoviewTableViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 15/04/22.
//

import UIKit

final class SearchMoviewTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    internal var loader: LoadingViewProtocol = LoadingView()
    //lazy var presenter: SearchMoviePresenter = SearchMoviePresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Movies"
        navigationItem.searchController = searchController
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return presenter.total
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
        //let factory = PosterTableViewCellFactory(tableView: tableView, indexPath: indexPath)
        //return factory.posterTableViewCell(with: presenter.elements[indexPath.row])
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
/*
extension SearchMoviewTableViewController: ListMoviesDisplayable {
    var presenter: CategoryListPresentable {
        <#code#>
    }

    func showLoader() {
        loader.addLoadingView(onView: view)
    }
    func dissmissLoader() {
        loader.removeLoadingView()
    }

    func loadFirstPage() {
        tableView.isHidden = false
        tableView.reloadData()
    }

    func loadNextPage(indexPath: [IndexPath]) {
        //let cellIndexPaths = presenter.visibleIndexPaths(in: tableView, intersecting: indexPath)
        //tableView.reloadRows(at: cellIndexPaths, with: .automatic)
    }

    func setupTable(viewModel: TableViewModel) {
        tableView.setUp(model: viewModel)
        //tableView.prefetchDataSource = self
    }
}*/
