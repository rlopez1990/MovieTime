//
//  UITableViewCellRegistrable.swift
//  MovieTime
//
//  Created by Raul Lopez Martinez on 14/04/22.
//

import UIKit

protocol UITableViewCellRegistrable {
    static var cellIdentifier: String { get }
}

extension UITableViewCellRegistrable {
    static var cellIdentifier: String {
        return String(describing: self)
    }

    static private var bundle: Bundle {
        return Bundle.main
    }

    static private var nib: UINib {
        return UINib(nibName: self.cellIdentifier, bundle: self.bundle)
    }
}


extension UITableViewCellRegistrable where Self: UITableViewCell {
    static func registerCell(into tableView: UITableView) {
        tableView.register(self.nib, forCellReuseIdentifier: self.cellIdentifier)
    }
}
