//
//  SceneDelegate.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        let splitVC = UISplitViewController()
        splitVC.preferredPrimaryColumnWidthFraction = 1/3
        let detailVC = ViewController()
        let newsFeedVC = NewsFeedVC()
        newsFeedVC.delegate = detailVC
        let masterNavigationController = UINavigationController(rootViewController: newsFeedVC)
        let detailNavigationController = UINavigationController(rootViewController: detailVC)
        splitVC.viewControllers = [masterNavigationController, detailNavigationController]
        window?.rootViewController = splitVC
        window?.makeKeyAndVisible()
    }
}
