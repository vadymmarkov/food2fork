//
//  ExploreCollectionViewCell.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class ExploreCollectionViewCell: UICollectionViewCell {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.oil()
        label.font = .body
        label.numberOfLines = 3
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
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(imageView, titleLabel, subtitleLabel, accessoryLabel)
        setupStyles()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupStyles() {
        contentView.backgroundColor = R.color.milk()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10

        layer.cornerRadius = contentView.layer.cornerRadius
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.4
    }

    private func setupConstraints() {
        let padding: CGFloat = 16

        NSLayoutConstraint.constrain(
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),

            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),

            accessoryLabel.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            accessoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            accessoryLabel.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: padding)
        )
    }
}
