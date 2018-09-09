//
//  RoundedLabel.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RoundedLabel: UILabel {
    private let inset = Dimensions.spacingMin

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: inset, dy: inset))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + 2 * inset,
            height: size.width + 2 * inset
        )
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }

    private func setupStyles() {
        backgroundColor = R.color.milk()
        textColor = R.color.brand()
        font = .accessory
        textAlignment = .center
        layer.borderColor = R.color.brand()?.cgColor
        layer.borderWidth = 2
    }
}
