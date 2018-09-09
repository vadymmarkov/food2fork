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
    private let controllerFactory: ControllerFactory
    private let logicController: ExploreLogicController
    private let imageLoader: ImageLoader
    private var recipes = [Recipe]()

    private lazy var collectionView: UICollectionView = self.makeCollectionView()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Init

    init(controllerFactory: ControllerFactory,
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
        NSLayoutConstraint.pin(collectionView, toView: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContent()
    }

    // MARK: - Content

    private func loadContent() {
        render(.loading)
        logicController.load(then: { [weak self] state in
            self?.render(state)
        })
    }

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildControllers()

        switch state {
        case .loading:
            break
        case .presenting(let recipes):
            self.recipes = recipes
            collectionView.reloadData()
        case .failed(let error):
            self.recipes = []
            collectionView.reloadData()
            add(childController: makeErrorViewController(with: error))
        }
    }

    // MARK: - Actions

    @objc private func handleRetryButtonTap() {
        loadContent()
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
        imageLoader.loadImage(at: recipe.imageUrl, to: cell.imageView)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.item]
        delegate?.exploreViewController(self, didSelectRecipe: recipe)
    }
}

// MARK: - Factory

private extension ExploreViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = R.color.seashell()
        collectionView.register(type: ExploreCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }

    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 16
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
    }

    func makeErrorViewController(with error: Error) -> UIViewController {
        let viewController = controllerFactory.makeErrorViewController(with: error)
        viewController.button.addTarget(self, action: #selector(handleRetryButtonTap), for: .touchUpInside)
        return viewController
    }
}
