//
//  ListMoviesDisplayable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import UIKit

protocol ListMoviesDisplayable: LoaderDisplayable {
    func loadFirstPage()
    func setupTable(viewModel: TableViewModel)
    func loadNextPage(indexPath: [IndexPath])
}

extension ListMoviesDisplayable where Self: UITableViewController, Self: UITableViewDataSourcePrefetching {

    func loadFirstPage() {
        tableView.isHidden = false
        tableView.reloadData()
    }

    func loadNextPage(indexPath: [IndexPath]) {
        let cellIndexPaths = visibleIndexPaths(in: tableView, intersecting: indexPath)
        tableView.reloadRows(at: cellIndexPaths, with: .automatic)
    }

    func setupTable(viewModel: TableViewModel) {
        tableView.setUp(model: viewModel)
        tableView.prefetchDataSource = self
    }

    // MARK: - Private functions
    private func visibleIndexPaths(in tableView: UITableView, intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
