//
//  UIViewController+Alert.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Present alert controller with a given text
    func presentAlert(text: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: handler)

        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        alertController.view.tintColor = R.color.brand()
    }
}
