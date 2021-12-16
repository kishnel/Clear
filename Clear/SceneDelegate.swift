//
//  SceneDelegate.swift
//  Clear
//
//  Created by Marcello Mascia on 15/12/2021.
//

import UIKit

class PippoController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .red
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentDashboard)))
	}

	@objc
	func presentDashboard() {

		let router = DashboardRouter(navigationController: navigationController!)
		router.build()
	}
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard UIApplication.isRunningTests == false else { return }
		guard let windowScene = (scene as? UIWindowScene) else { return }

		self.window = {
			let window = UIWindow(windowScene: windowScene)

//			let navigationController = UINavigationController()
//			let router = DashboardRouter(navigationController: navigationController)
//			router.build()
//			window.rootViewController = navigationController
			window.rootViewController = UINavigationController(rootViewController: PippoController())

			return window
		}()
		self.window?.makeKeyAndVisible()
	}
}
