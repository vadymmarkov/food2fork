//
//  RecipeIngredientsView.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RecipeIngredientsView: UIView {
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.brand()
        label.font = .title
        return label
    }()

    private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.steel()
        label.font = .body
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleLabel, textLabel)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    private func setupConstraints() {
        let spacing: CGFloat = 16

        NSLayoutConstraint.constrain(
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),

            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            bottomAnchor.constraint(equalTo: textLabel.bottomAnchor)
        )
    }
}
