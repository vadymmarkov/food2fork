//
//  RecipeViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RecipeViewController: UIViewController {
    private var recipe: Recipe
    private let controllerFactory: ControllerFactory
    private let logicController: RecipeLogicController
    private let imageLoader: ImageLoader

    private lazy var headerView = RecipeHeaderView()
    private lazy var ingredientsView = RecipeIngredientsView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, ingredientsView])
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = R.color.milk()
        scrollView.contentInset.bottom = Dimensions.spacingMax
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView
    }()

    // MARK: - Init

    init(recipe: Recipe,
         controllerFactory: ControllerFactory,
         logicController: RecipeLogicController,
         imageLoader: ImageLoader) {
        self.recipe = recipe
        self.controllerFactory = controllerFactory
        self.logicController = logicController
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render(.presenting(recipe))
        loadContent()
    }

    // MARK: - Content

    private func loadContent() {
        logicController.load(id: recipe.id, then: { [weak self] state in
            self?.render(state)
        })
    }

    private func render(_ state: ViewState<Recipe>) {
        removeAllChildControllers()

        switch state {
        case .loading:
            break
        case .presenting(let recipe):
            self.recipe = recipe
            present(recipe: recipe)
        case .failed(let error):
            add(childController: makeErrorViewController(with: error))
        }
    }

    private func present(recipe: Recipe) {
        imageLoader.loadImage(at: recipe.imageUrl, to: headerView.imageView)
        headerView.titleLabel.text = recipe.title
        headerView.subtitleLabel.text = recipe.publisher
        headerView.accessoryLabel.text = "\(Int(recipe.socialRank))"
        ingredientsView.titleLabel.text = R.string.localizable.ingredients()
        ingredientsView.textLabel.text = recipe.ingredients?.joined(separator: "\n\n")
    }

    // MARK: - Actions

    @objc private func handleRetryButtonTap() {
        loadContent()
    }

    @objc private func handleFavoriteButtonTap() {

    }

    // MARK: - Layout

    private func setupConstraints() {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.constrain(
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            )
        } else {
            NSLayoutConstraint.constrain(
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            )
        }

        NSLayoutConstraint.constrain(
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        )
    }
}

// MARK: - Factory

private extension RecipeViewController {
    func makeErrorViewController(with error: Error) -> UIViewController {
        let viewController = controllerFactory.makeErrorViewController(with: error)
        viewController.button.addTarget(self, action: #selector(handleRetryButtonTap), for: .touchUpInside)
        return viewController
    }
}
