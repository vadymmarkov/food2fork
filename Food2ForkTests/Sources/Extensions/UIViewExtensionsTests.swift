//
//  UICollectionViewReusableCellsTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class UICollectionViewReusableCellsTests: XCTestCase {
    private var collectionView: UICollectionView!

    override func setUp() {
        super.setUp()
        collectionView = UICollectionView()
    }

    func testRegisterAndDequeue() {
        collectionView.register(type: Cell.self)
    }

    func testDequeue() {
    }
}

// MARK: - Private

private final class Cell: UICollectionViewCell {}
