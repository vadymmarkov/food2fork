//
//  PaginatorTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class PaginatorTests: XCTestCase {
    private var paginator: Paginator!
    private var scrollView: UIScrollView!

    override func setUp() {
        super.setUp()
        paginator = Paginator()
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        scrollView.contentSize = CGSize(width: 320, height: 680)
    }

    // MARK: - Tests

    func testNext() {
        paginator.next()
        XCTAssertEqual(paginator.page, 2)

        paginator.next()
        XCTAssertEqual(paginator.page, 3)
    }

    func testReset() {
        paginator.next()
        paginator.isLocked = true
        paginator.isLastPage = true

        paginator.reset()
        XCTAssertEqual(paginator.page, 1)
        XCTAssertFalse(paginator.isLocked)
        XCTAssertFalse(paginator.isLastPage)
    }

    func testShouldPaginate() {
        scrollView.contentOffset.y = 100
        XCTAssertFalse(paginator.shouldPaginate(scrollView: scrollView))

        scrollView.contentOffset.y = 300
        XCTAssertTrue(paginator.shouldPaginate(scrollView: scrollView))
    }

    func testShouldPaginateWhenLocked() {
        scrollView.contentOffset.y = 300
        paginator.isLocked = true
        XCTAssertFalse(paginator.shouldPaginate(scrollView: scrollView))
    }

    func testShouldPaginateWhenLastPage() {
        scrollView.contentOffset.y = 300
        paginator.isLastPage = true
        XCTAssertFalse(paginator.shouldPaginate(scrollView: scrollView))
    }
}
