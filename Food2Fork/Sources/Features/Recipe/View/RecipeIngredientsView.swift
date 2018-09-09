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
        NSLayoutConstraint.constrain(
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),

            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),

            bottomAnchor.constraint(equalTo: textLabel.bottomAnchor)
        )
    }
}
