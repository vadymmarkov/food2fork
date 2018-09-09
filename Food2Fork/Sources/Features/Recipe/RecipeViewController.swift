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
        stackView.spacing = Dimensions.spacingMax
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

    private lazy var favoriteButton = UIBarButtonItem(
        image: R.image.iconFavorite(),
        style: .plain,
        target: self,
        action: #selector(handleFavoriteButtonTap)
    )

    private lazy var refreshControl = UIRefreshControl()

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
        favoriteButton.tintColor = R.color.carnation()
        navigationItem.rightBarButtonItem = favoriteButton
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        scrollView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(loadContent), for: .valueChanged)

        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render(.presenting(recipe))
        loadContent()
    }

    // MARK: - Content

    @objc private func loadContent() {
        logicController.load(id: recipe.id, then: { [weak self] state in
            self?.render(state)
        })
    }

    private func render(_ state: ViewState<Recipe>) {
        removeAllChildControllers()
        favoriteButton.isEnabled = false

        switch state {
        case .loading:
            break
        case .presenting(let recipe):
            self.recipe = recipe
            present(recipe: recipe)
        case .failed:
            break
        }
    }

    private func present(recipe: Recipe) {
        imageLoader.loadImage(at: recipe.imageUrl, to: headerView.imageView)
        headerView.titleLabel.text = recipe.title
        headerView.subtitleLabel.text = recipe.publisher
        headerView.accessoryLabel.text = "\(Int(recipe.socialRank))"
        ingredientsView.titleLabel.text = R.string.localizable.ingredients()
        ingredientsView.textLabel.text = recipe.ingredients?.map({ "• \($0)" }).joined(separator: "\n\n")
        updateFavoriteButton(isFavorite: recipe.isFavorite)
    }

    private func updateFavoriteButton(isFavorite: Bool) {
        favoriteButton.image = isFavorite ? R.image.iconFavoriteSelected() : R.image.iconFavorite()
        favoriteButton.isEnabled = true
    }

    // MARK: - Actions

    @objc private func handleFavoriteButtonTap() {
        let action = recipe.isFavorite ? logicController.unlike : logicController.like

        do {
            try action(recipe)
            recipe.isFavorite = !recipe.isFavorite
            updateFavoriteButton(isFavorite: recipe.isFavorite)
        } catch {
            presentAlert(text: error.localizedDescription)
        }
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
        viewController.button.addTarget(self, action: #selector(loadContent), for: .touchUpInside)
        return viewController
    }
}
