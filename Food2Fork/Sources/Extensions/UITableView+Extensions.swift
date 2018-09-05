//
//  UITableView+Extensions.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    func dequeue<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        } else {
            assertionFailure("Incorrect type of cell")
            return T.init()
        }
    }
}
