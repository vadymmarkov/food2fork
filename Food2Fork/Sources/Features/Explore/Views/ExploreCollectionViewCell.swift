//
//  ExploreCollectionViewCell.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class ExploreCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setupStyles()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupStyles() {
        contentView.backgroundColor = R.color.backgroundSecondary()
        contentView.layer.cornerRadius = 10
    }

    private func setupConstraints() {
        NSLayoutConstraint.pin(imageView, toView: contentView)
    }
}
