//
//  Paginator.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class Paginator {
    var isLocked = false
    var isLastPage = false
    private(set) var page = 1

    func next() {
        page += 1
    }

    func reset() {
        page = 1
        isLocked = false
        isLastPage = false
    }

    func shouldPaginate(scrollView: UIScrollView) -> Bool {
        guard !isLocked && !isLastPage else {
            return false
        }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        return offsetY > contentHeight - scrollView.frame.size.height
    }
}
