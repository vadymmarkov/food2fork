//
//  ExploreViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class ExploreViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.backgroundPrimary()
        navigationItem.title = R.string.localizable.explore()
    }
}
