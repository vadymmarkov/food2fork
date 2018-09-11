//
//  Functions.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Foundation

func performUIUpdate(using closure: @escaping () -> Void) {
    // If we are already on the main thread, execute the closure directly
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: closure)
    }
}
