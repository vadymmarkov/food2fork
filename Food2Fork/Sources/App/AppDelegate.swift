//
//  AppDelegate.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 03/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var dependencyContainer = DependencyContainer()
    private lazy var appFlowController = self.dependencyContainer.makeAppFlowController()
    private let configurators: [BootstrapConfiguring] = [
        AppearanceConfigurator()
    ]

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appFlowController
        window?.makeKeyAndVisible()

        configurators.forEach {
            $0.configure()
        }

        return true
    }
}
