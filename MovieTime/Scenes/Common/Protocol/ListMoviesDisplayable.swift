//
//  ListMoviesDisplayable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 16/04/22.
//

import Foundation

protocol ListMoviesDisplayable: AnyObject {
    var loader: LoadingViewProtocol { get }
    var presenter: CategoryListPresentable { get }

    func showLoader()
    func dissmissLoader()
    func loadFirstPage()
    func setupTable(viewModel: TableViewModel)
    func loadNextPage(indexPath: [IndexPath])
}
