//
//  ListPresentable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

/// Protocol used by Presenter
protocol ListPressentable {
    var view: ListMoviesDisplayable? { get }
    var elements: [PosterViewModel] { get }
    var viewCoordinator: ViewCoordinator { get }
    var total: Int { get }

    func setupController()
    func gotToDetail(row: Int, navigationController: UINavigationController?)
    func shouldShowLoadingCell(for indexPath: IndexPath) -> Bool
    func visibleIndexPaths(in tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath]
}

extension ListMoviesDisplayable where Self: UITableViewController, Self: UITableViewDataSourcePrefetching {
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
        let cellIndexPaths = presenter.visibleIndexPaths(in: tableView, intersecting: indexPath)
        tableView.reloadRows(at: cellIndexPaths, with: .automatic)
    }

    func setupTable(viewModel: TableViewModel) {
        tableView.setUp(model: viewModel)
        tableView.prefetchDataSource = self
    }
}
