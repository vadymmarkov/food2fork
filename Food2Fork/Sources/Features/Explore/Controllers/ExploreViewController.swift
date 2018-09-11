//
//  ExploreViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

protocol ExploreViewControllerDelegate: AnyObject {
    func exploreViewController(_ viewController: ExploreViewController, didSelectRecipe recipe: Recipe)
}

final class ExploreViewController: UIViewController {
    weak var delegate: ExploreViewControllerDelegate?
    private let controllerFactory: UtilityControllerFactory
    private let logicController: ExploreLogicController
    private let imageLoader: ImageLoader
    private let paginator = Paginator()
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

    init(controllerFactory: UtilityControllerFactory,
         logicController: ExploreLogicController,
         imageLoader: ImageLoader) {
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
        paginator.reset()
        render(.loading)
        loadContent()
    }

    private func loadContent() {
        paginator.isLocked = true
        logicController.load(page: paginator.page, then: { [weak self] state in
            self?.render(state)
            self?.paginator.isLocked = false
        })
    }

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildControllers()

        switch state {
        case .loading:
            if recipes.isEmpty {
                add(childController: controllerFactory.makeLoadingViewController())
            }
        case .presenting(let recipes):
            if paginator.page == 0 {
                self.recipes = recipes
            } else {
                self.recipes.append(contentsOf: recipes)
            }
            paginator.isLastPage = recipes.isEmpty
            collectionView.reloadData()

            if self.recipes.isEmpty {
                add(childController: makeInfoViewController())
            }
        case .failed(let error):
            self.recipes = []
            collectionView.reloadData()
            add(childController: makeErrorViewController(with: error))
        }

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - Factory

private extension ExploreViewController {
    func makeErrorViewController(with error: Error) -> UIViewController {
        let viewController = controllerFactory.makeInfoViewController(with: error)
        viewController.button.addTarget(self, action: #selector(reload), for: .touchUpInside)
        return viewController
    }

    func makeInfoViewController() -> UIViewController {
        let viewController = controllerFactory.makeInfoViewController()
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
        delegate?.exploreViewController(self, didSelectRecipe: recipe)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard paginator.shouldPaginate(scrollView: scrollView) else {
            return
        }
        paginator.next()
        loadContent()
    }
}
