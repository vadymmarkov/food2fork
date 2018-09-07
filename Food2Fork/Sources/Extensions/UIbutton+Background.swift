//
//  UIbutton+Background.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 07/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor?, forState: UIControlState) {
        guard let color = color else {
            return
        }

        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }
}
