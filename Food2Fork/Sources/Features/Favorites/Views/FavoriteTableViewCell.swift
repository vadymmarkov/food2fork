//
//  FavoriteTableViewCell.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    private(set) lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.milk()
        label.font = .subtitle
        label.numberOfLines = 3
        return label
    }()

    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.seashell()
        label.font = .body
        label.numberOfLines = 2
        return label
    }()

    private(set) lazy var accessoryLabel: UILabel = {
        let label = RoundedLabel()
        label.backgroundColor = .clear
        label.textColor = R.color.milk()
        label.layer.borderColor = R.color.milk()?.cgColor
        return label
    }()

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        return gradientLayer
    }()

    // MARK: - Init

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coverImageView)
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubviews(titleLabel, subtitleLabel, accessoryLabel)
        setupStyles()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
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

        NSLayoutConstraint.pin(coverImageView, toView: contentView)

        NSLayoutConstraint.constrain(
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            subtitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),

            accessoryLabel.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            accessoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),

            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            titleLabel.widthAnchor.constraint(equalTo: subtitleLabel.widthAnchor)
        )
    }
}
