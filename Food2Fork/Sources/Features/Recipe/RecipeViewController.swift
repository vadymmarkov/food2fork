//
//  RecipeViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RecipeViewController: UIViewController {
    private lazy var headerView = RecipeHeaderView()
    private lazy var ingredientsView = RecipeIngredientsView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, ingredientsView])
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = R.color.milk()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()

    // MARK: - Init

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        setupConstraints()
    }

    // MARK: - Layout

    private func setupConstraints() {
        NSLayoutConstraint.pin(scrollView, toView: view)
        NSLayoutConstraint.constrain(
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        )
    }
}
