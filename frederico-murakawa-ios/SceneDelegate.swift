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

        let articlesProvider = ArticlesProvider(apiSession: APISession())
        let viewModel = NewsFeedViewModel(articlesProvider: articlesProvider)
        let newsFeedVC = NewsFeedVC(viewModel: viewModel)
        let masterNavigationController = UINavigationController(rootViewController: newsFeedVC)

        let splitVC = UISplitViewController()
        splitVC.viewControllers = [masterNavigationController]

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = splitVC
        window?.makeKeyAndVisible()
    }
}

