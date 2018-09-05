//
//  NSLayoutConstraints+Extensions.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /// Add layout constraints to a view.
    @discardableResult
    static func constrain(activate: Bool = true,
                          _ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        for constraint in constraints {
            (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
        }

        if activate {
            NSLayoutConstraint.activate(constraints.compactMap { $0 })
        }

        return constraints.compactMap { $0 }
    }

    /// Pin a view to another view using constraints.
    @discardableResult
    static func pin(_ view: UIView,
                    toView: UIView,
                    activate: Bool = true,
                    insets: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)) -> [NSLayoutConstraint] {
        let constraints = NSLayoutConstraint.constrain(
            activate: activate,
            view.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -insets.right),
            view.topAnchor.constraint(equalTo: toView.topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -insets.bottom)
        )

        return constraints.compactMap { $0 }
    }
}
