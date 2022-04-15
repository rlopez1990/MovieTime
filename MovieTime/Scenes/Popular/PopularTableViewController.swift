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
    func loadData(items: [PosterViewModel])
    func setupTable(viewModel: TableViewModel)
}

final class PopularTableViewController: UITableViewController {
    // MARK: - Public properties
    lazy var presenter: PopularPresentable = PopularPresenter(view: self)

    // MARK: - Private properties
    private var elements: [PosterViewModel] = [] {
       didSet {
           tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PosterTableViewCell.registerCell(into: tableView)
        presenter.setupController()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let factory = PosterTableViewCellFactory(tableView: tableView, indexPath: indexPath)
        let cell = factory.createCell(viewModel: elements[indexPath.row])
        return cell
    }
}

extension PopularTableViewController: PopularMoviesDisplayable {
    func showLoader() {}
    func dissmissLoader() {}

    func loadData(items: [PosterViewModel]) {

    }

    func setupTable(viewModel: TableViewModel) {
        tableView.setUp(model: viewModel)
    }

}
