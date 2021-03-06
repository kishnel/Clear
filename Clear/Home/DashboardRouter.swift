//
//  DashboardRouter.swift
//  Clear
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation
import UIKit

protocol DashboardRouterProtocol: AnyObject {

	func showDetail(animated: Bool)
}

class DashboardRouter {

	private let navigationController: UINavigationController

	init(navigationController: UINavigationController) {

		self.navigationController = navigationController
	}

	func build() {

		let presenter = DashboardPresenter()
		let interactor = DashboardInteractor(presenter: presenter, router: self)

		let view = DashboardViewController(interactor: interactor)

		presenter.view = view

		navigationController.pushViewController(view, animated: true)
	}
}

extension DashboardRouter: DashboardRouterProtocol {

	func showDetail(animated: Bool) {

		let controller = UIViewController()
		controller.view.backgroundColor = .green
		navigationController.pushViewController(controller, animated: animated)
	}
}
