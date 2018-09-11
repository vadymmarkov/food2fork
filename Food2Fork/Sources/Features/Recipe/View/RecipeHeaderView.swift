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

    private(set) lazy var button: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.setBackgroundColor(R.color.underline(), forState: .normal)
        button.titleLabel?.font = .subtitle
        button.setTitleColor(R.color.steel(), for: .normal)
        return button
    }()

    private(set) lazy var accessoryLabel: UILabel = {
        let label = RoundedLabel()
        label.font = .title
        label.layer.borderWidth = 3
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(imageView, titleLabel, button, accessoryLabel)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupConstraints() {
        let spacing = Dimensions.spacingMax

        NSLayoutConstraint.constrain(
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.66),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

            accessoryLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            accessoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),

            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            button.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.6),

            bottomAnchor.constraint(equalTo: button.bottomAnchor)
        )
    }
}
