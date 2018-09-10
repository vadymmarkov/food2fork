//
//  UICollectionView+ReusableCells.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(type: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    func dequeue<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        } else {
            assertionFailure("Incorrect type of cell")
            return T.init()
        }
    }
}
