//
//  JSONCache.swift
//  Food2Fork
//
//  Created by Vadym Markov on 06/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Foundation

final class DiskCache {
    private let fileManager: FileManager

    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }

    func loadData(forKey: String, then completion: (Data?) -> Void) {

    }
}
