//
//  PopularTableViewController.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit


protocol APISearchable {
    var searchType: SearchType { get }
}

final class PopularTableViewController: UITableViewController, APISearchable, ListMoviesDisplayable {

    // MARK: - Public properties
    var searchType: SearchType = .popular
    lazy var presenter: CategoryListPresentable = PopularPresenter(view: self)
    lazy var loader: LoadingViewProtocol = LoadingView()

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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.gotToDetail(row: indexPath.row, navigationController: navigationController)
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

