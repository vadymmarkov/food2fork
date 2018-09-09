//
//  RecipeHeaderView.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RecipeHeaderView: UIView {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.oil()
        label.font = .title
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.steel()
        label.font = .subtitle
        label.numberOfLines = 2
        return label
    }()

    private(set) lazy var accessoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.brand()
        label.font = .accessory
        label.numberOfLines = 2
        label.textAlignment = .right
        return label
    }()

    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: subtitleLabel.frame.maxY)
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(imageView, titleLabel, subtitleLabel, accessoryLabel)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupConstraints() {
        let spacing: CGFloat = 16

        NSLayoutConstraint.constrain(
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.66),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            subtitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

            accessoryLabel.topAnchor.constraint(equalTo: subtitleLabel.topAnchor),
            accessoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            accessoryLabel.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: spacing),

            bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor)
        )
    }
}
