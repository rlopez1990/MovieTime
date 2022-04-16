//
//  PopularTableViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol PopularMoviesDisplayable: AnyObject {
    func showLoader()
    func dissmissLoader()
    func loadFirstPage()
    func loadNextPage(indexPath: [IndexPath])
    func setupTable(viewModel: TableViewModel)
}

enum SearchType: String {
    case popular = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case search = "search/moview"
}

final class PopularTableViewController: UITableViewController {
    // MARK: - Public properties
    var searchType: SearchType = .popular
    lazy var presenter: PopularPresentable = PopularPresenter(view: self)

    // MARK: - Private properties}

    override func viewDidLoad() {
        super.viewDidLoad()
        PosterTableViewCell.registerCell(into: tableView)
        LoaderTableViewCell.registerCell(into: tableView)
        presenter.setupController()
        presenter.fetchData(from: searchType)
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
extension PopularTableViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
      if indexPaths.contains(where: presenter.shouldShowLoadingCell(for:)) {
          presenter.fetchData(from: searchType)
      }
  }
}

extension PopularTableViewController: PopularMoviesDisplayable {
    func showLoader() {}
    func dissmissLoader() {}

    func loadFirstPage() {
        //indicatorView.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }

    func loadNextPage(indexPath: [IndexPath]) {
        let cellIndexPaths = presenter.visibleIndexPaths(in: tableView, intersecting: indexPath)
        tableView.reloadRows(at: cellIndexPaths, with: .automatic)
    }

    func setupTable(viewModel: TableViewModel) {
        tableView.setUp(model: viewModel)
        tableView.prefetchDataSource = self
    }
}
