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
        label.backgroundColor = R.color.milk()
        label.textColor = R.color.oil()
        label.font = .body
        label.numberOfLines = 3
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = R.color.milk()
        label.textColor = R.color.steel()
        label.font = .accessoryLight
        label.numberOfLines = 2
        return label
    }()

    private(set) lazy var accessoryLabel = RoundedLabel()

    private(set) lazy var favoriteView: UIImageView = {
        let imageView = UIImageView(image: R.image.iconFavoriteSelected()?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = R.color.milk()
        return imageView
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.5).cgColor, UIColor.clear.cgColor]
        return gradientLayer
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubviews(titleLabel, subtitleLabel, accessoryLabel, favoriteView)
        setupStyles()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 2)
    }

    private func setupStyles() {
        backgroundColor = R.color.milk()
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
        let spacing = Dimensions.spacingMax

        NSLayoutConstraint.constrain(
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

            favoriteView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Dimensions.spacingMin),
            favoriteView.trailingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: -Dimensions.spacingMin
            ),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),

            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            accessoryLabel.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            accessoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing)
        )
    }
}
