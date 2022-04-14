//
//  PopularPresenter.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol PopularPresentable {
    func setupController()
}

final class PopularPresenter {
    weak var view: PopularTableViewController?

    init(view: PopularTableViewController?) {
        self.view = view
    }
}

extension PopularPresenter: PopularPresentable {
    func setupController() {

    }
}

// MARK: - Private methods
private extension PopularPresenter {
    func viewModels(from resultResponse: ResultResponse) -> PosterViewModel {
        
    }
}
