//
//  ExploreViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class ExploreViewController: UIViewController {
    private let viewControllerFactory: UtilityViewControllerFactory
    private let navigator: RecipeNavigator
    private let logicController: ExploreLogicController
    private let imageLoader: ImageLoader
    private var recipes = [Recipe]()

    private lazy var refreshControl = UIRefreshControl()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = R.color.seashell()
        collectionView.register(type: ExploreCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let spacing: CGFloat = Dimensions.spacingMax
        let screenWidth = UIScreen.main.bounds.width
        let itemsPerRow: CGFloat = 2
        let width = (screenWidth - 3 * spacing) / itemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        return layout
    }()

    // MARK: - Init

    init(viewControllerFactory: UtilityViewControllerFactory,
         navigator: RecipeNavigator,
         logicController: ExploreLogicController,
         imageLoader: ImageLoader) {
        self.navigator = navigator
        self.viewControllerFactory = viewControllerFactory
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
        navigationItem.title = R.string.localizable.explore()
        view.backgroundColor = R.color.seashell()
        view.addSubview(collectionView)

        collectionView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)

        NSLayoutConstraint.pin(collectionView, toView: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }

    // MARK: - Content

    @objc private func reload() {
        render(.loading)
        logicController.load(then: { [weak self] state in
            self?.render(state)
        })
    }

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildViewControllers()

        switch state {
        case .loading:
            if recipes.isEmpty {
                add(childViewController: viewControllerFactory.makeLoadingViewController())
            }
        case .presenting(let recipes):
            self.recipes = recipes
            collectionView.reloadData()

            if self.recipes.isEmpty {
                add(childViewController: makeInfoViewController())
            }
        case .failed(let error):
            self.recipes = []
            collectionView.reloadData()
            add(childViewController: makeErrorViewController(with: error))
        }

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - Factory

private extension ExploreViewController {
    func makeErrorViewController(with error: Error) -> UIViewController {
        let viewController = viewControllerFactory.makeInfoViewController(with: error)
        viewController.button.addTarget(self, action: #selector(reload), for: .touchUpInside)
        return viewController
    }

    func makeInfoViewController() -> UIViewController {
        let viewController = viewControllerFactory.makeInfoViewController()
        viewController.titleLabel.text = R.string.localizable.exploreInfoTitle()
        viewController.textLabel.text = R.string.localizable.exploreInfoText()
        viewController.button.addTarget(self, action: #selector(reload), for: .touchUpInside)
        return viewController
    }
}

// MARK: - UICollectionViewDataSource

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(type: ExploreCollectionViewCell.self, indexPath: indexPath)
        let recipe = recipes[indexPath.item]
        cell.titleLabel.text = recipe.title
        cell.subtitleLabel.text = recipe.publisher
        cell.accessoryLabel.text = "\(Int(recipe.socialRank))"
        cell.favoriteView.isHidden = !recipe.isFavorite

        cell.gradientLayer.isHidden = true
        imageLoader.loadImage(at: recipe.imageUrl, to: cell.imageView, completion: { [weak cell] image in
            cell?.gradientLayer.isHidden = image == nil
        })

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.item]
        navigator.navigate(to: recipe)
    }
}
