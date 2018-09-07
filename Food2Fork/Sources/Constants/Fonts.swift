//
//  FontGuide.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension UIFont {
    static var title: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    static var body: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    static var subtitle: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .light)
    }

    static var accessory: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
}
