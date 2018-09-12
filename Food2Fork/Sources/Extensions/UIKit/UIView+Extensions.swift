//
//  UIView+Extensions.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(reflecting: self)
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }

    /// Make image snapshot from the view.
    func makeSnapshot() -> UIImageView {
        UIGraphicsBeginImageContext(frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImageView(image: image)
    }
}
