//
//  AppearanceConfigurator.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class AppearanceConfigurator: BootstrapConfiguring {
    func configure() {
        // UINavigationBar
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = R.color.brand()
        navigationBar.titleTextAttributes = [
            .font: UIFont.title,
            .foregroundColor: R.color.oil()!
        ]

        // UISearchBar
        let searchBarButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchBarButtonItem.tintColor = R.color.brand()
    }
}
