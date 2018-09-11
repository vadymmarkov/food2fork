//
//  LoadingViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class LoadingViewController: UIViewController {
    private lazy var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(activityIndicator)

        NSLayoutConstraint.constrain(
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
}
