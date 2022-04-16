//
//  PosterTableViewCellFactory.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

final class PosterTableViewCellFactory {
    private let tableView: UITableView
    private let indexPath: IndexPath

    init(tableView: UITableView, indexPath: IndexPath) {
        self.tableView = tableView
        self.indexPath = indexPath
    }

    func posterTableViewCell(with viewModel: PosterViewModel) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.cellIdentifier, for: indexPath) as? PosterTableViewCell else {
            return .init()
        }
        cell.setup(viewModel: viewModel)
        return cell
    }

    func loaderTableViewCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoaderTableViewCell.cellIdentifier, for: indexPath) as? LoaderTableViewCell else {
            return .init()
        }
        return cell
    }
}
