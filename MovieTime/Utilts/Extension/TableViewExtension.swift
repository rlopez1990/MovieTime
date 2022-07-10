//
//  TableViewExtension.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

extension UITableView {
    func setUp(model: TableViewModel) {
        self.allowsSelection = model.allowSelection
        self.rowHeight = 90//UITableView.automaticDimension
        self.estimatedRowHeight = UITableView.automaticDimension
        self.separatorStyle = model.separatorStyle
    }
}
