//
//  InfoViewController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 06/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController {
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = R.color.info()
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.oil()
        label.font = .title
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.steel()
        label.font = .body
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private(set) lazy var button: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(R.color.brand(), forState: .normal)
        button.setBackgroundColor(R.color.brand()?.withAlphaComponent(0.7), forState: .highlighted)
        button.setBackgroundColor(R.color.brand()?.withAlphaComponent(0.7), forState: .selected)
        button.setTitleColor(R.color.milk(), for: .normal)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
        view.addSubviews(imageView, titleLabel, textLabel, button)
        setupConstraints()
    }

    // MARK: - Layout

    private func setupConstraints() {
        let spacing = Dimensions.spacingMax

        NSLayoutConstraint.constrain(
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -spacing * 4),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),

            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),

            button.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: spacing),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        )
    }
}
