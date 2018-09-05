//
//  ExploreViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

protocol ExploreViewControllerDelegate: AnyObject {
    func exploreViewController(_ viewController: ExploreViewController, didSelectRecipe: Recipe)
}

final class ExploreViewController: UIViewController {
    weak var delegate: ExploreViewControllerDelegate?
    private let recipes = [Recipe]()
    private lazy var collectionView: UICollectionView = self.makeCollectionView()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localizable.explore()

        view.backgroundColor = R.color.backgroundPrimary()
        view.addSubview(collectionView)
        NSLayoutConstraint.pin(collectionView, toView: view)

        collectionView.reloadData()
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

// MARK: - Subviews factory

private extension ExploreViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(type: ExploreCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }

    func makeCollectionViewLayout() -> UICollectionViewLayout {
        let padding: CGFloat = 16
        let screenWidth = UIScreen.main.bounds.width
        let itemsPerRow: CGFloat = 2
        let size = (screenWidth - 4 * padding) / itemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: size, height: size)
        return layout
    }
}
