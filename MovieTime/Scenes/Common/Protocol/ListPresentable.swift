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
}

extension ListPressentable {
    func setupController() {
        let viewModel = TableViewModel(allowSelection: true,
                                       cellHeight: UITableView.automaticDimension,
                                       separatorStyle: .singleLine)
        view?.setupTable(viewModel: viewModel)
    }

    func gotToDetail(row: Int, navigationController: UINavigationController?) {
        let movieIdentifier = elements[row].movieIdentifier
        viewCoordinator.goDetails(for: movieIdentifier,
                                     navigationController: navigationController)
    }

    func shouldShowLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= elements.count
    }
}
