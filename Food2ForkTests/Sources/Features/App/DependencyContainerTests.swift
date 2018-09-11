//
//  DependencyContainerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class DependencyContainerTests: XCTestCase {
    private var container: DependencyContainer!

    override func setUp() {
        super.setUp()
        container = DependencyContainer()
    }

    override func tearDown() {
        Endpoint.baseUrl = nil
        Endpoint.headers = [:]
        super.tearDown()
    }

    // MARK: - Tests

    func testInit() {
        let apiConfig = APIConfig()
        XCTAssertEqual(Endpoint.baseUrl?.urlString, apiConfig.baseUrl)
        XCTAssertEqual(Endpoint.headers, ["Accept": apiConfig.acceptHeader])
    }

    func testMakeMainViewController() {
        let controller = container.makeMainViewController() as? UITabBarController
        XCTAssertEqual(controller?.tabBar.tintColor, R.color.brand())

        XCTAssertTrue(controller?.viewControllers?[0] is UINavigationController)
        XCTAssertTrue(controller?.viewControllers?[1] is UINavigationController)
        XCTAssertTrue(controller?.viewControllers?[2] is UINavigationController)
    }

    func testMakeExploreNavigationController() {
        let controller = container.makeExploreNavigationController()
        XCTAssertEqual(controller.tabBarItem.title, R.string.localizable.explore())
        XCTAssertEqual(controller.tabBarItem.image, R.image.tabExplore())
        XCTAssertEqual(controller.tabBarItem.selectedImage, R.image.tabExplore())
        XCTAssertTrue(controller.topViewController is ExploreViewController)
    }

    func testMakeSearchFlowController() {
        let controller = container.makeSearchNavigationController()
        XCTAssertEqual(controller.tabBarItem.title, R.string.localizable.search())
        XCTAssertEqual(controller.tabBarItem.image, R.image.tabSearch())
        XCTAssertEqual(controller.tabBarItem.selectedImage, R.image.tabSearch())
        XCTAssertTrue(controller.topViewController is SearchViewController)
    }

    func testMakeFavoritesFlowController() {
        let controller = container.makeFavoritesNavigationController()
        XCTAssertEqual(controller.tabBarItem.title, R.string.localizable.favorites())
        XCTAssertEqual(controller.tabBarItem.image, R.image.tabFavorites())
        XCTAssertEqual(controller.tabBarItem.selectedImage, R.image.tabFavorites())
        XCTAssertTrue(controller.topViewController is FavoritesViewController)
    }

    func testMakeInfoViewController() {
        let viewController = container.makeInfoViewController()
        XCTAssertEqual(viewController.button.currentTitle, R.string.localizable.retry())
        XCTAssertEqual(viewController.imageView.image, R.image.logo()?.withRenderingMode(.alwaysTemplate))
    }

    func testMakeInfoViewControllerWithError() {
        let error = TestError(errorDescription: "Test")
        let viewController = container.makeInfoViewController(with: error)
        XCTAssertEqual(viewController.titleLabel.text, R.string.localizable.errorTitle())
        XCTAssertEqual(viewController.textLabel.text, "Test")
        XCTAssertEqual(viewController.button.currentTitle, R.string.localizable.retry())
        XCTAssertEqual(viewController.imageView.image, R.image.logo()?.withRenderingMode(.alwaysTemplate))
    }

    func testMakeAlertController() {
        let alertController = container.makeAlertController(text: "Test", handler: { _ in })
        XCTAssertEqual(alertController.message, "Test")
        XCTAssertEqual(alertController.actions.first?.title, R.string.localizable.ok())
        XCTAssertEqual(alertController.actions.first?.style, .default)
    }
}

// MARK: - Private

private struct TestError: LocalizedError {
    let errorDescription: String?
}
