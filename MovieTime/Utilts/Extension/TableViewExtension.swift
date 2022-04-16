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
        self.rowHeight = 90.0//model.cellHeight
        //self.estimatedRowHeight = 90.0
        self.separatorStyle = model.separatorStyle
    }
}
