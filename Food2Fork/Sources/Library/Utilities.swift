//
//  Utilities.swift
//  Food2Fork
//
//  Created by Vadym Markov on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Foundation

struct Utilities {
    static var isUITesting: Bool {
        return CommandLine.arguments.contains("--UITests")
    }
}
