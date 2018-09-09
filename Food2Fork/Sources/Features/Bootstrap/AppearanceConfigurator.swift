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
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = R.color.brand()
        navigationBar.titleTextAttributes = [
            .font: UIFont.title,
            .foregroundColor: R.color.oil()!
        ]
    }
}
