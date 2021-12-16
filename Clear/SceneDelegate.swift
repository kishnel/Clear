//
//  SceneDelegate.swift
//  Clear
//
//  Created by Marcello Mascia on 15/12/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard UIApplication.isRunningTests == false else { return }
		guard let windowScene = (scene as? UIWindowScene) else { return }

		self.window = {
			let window = UIWindow(windowScene: windowScene)

			let navigationController = UINavigationController()
			let router = DashboardRouter(navigationController: navigationController)
			router.build()
			window.rootViewController = navigationController

			return window
		}()
		self.window?.makeKeyAndVisible()
	}
}
