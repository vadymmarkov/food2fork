//
//  Functions.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Foundation

/// If we are already on the main thread, execute the closure directly.
func performUIUpdate(using closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}

var isTesting: Bool {
    return isUITesting || isUnitTesting
}

var isUITesting: Bool {
    return CommandLine.arguments.contains("--UITests")
}

var isUnitTesting: Bool {
    return NSClassFromString("XCTest") != nil
}
