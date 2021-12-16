//
//  DashboardInteractor.swift
//  Clear
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation
import NetworkModule

protocol DashboardInteractorProtocol: AnyObject {

	func viewDidLoad()
}

class DashboardInteractor {

	private let presenter: DashboardPresenterProtocol
	private let router: DashboardRouterProtocol

	deinit {
		print("DEINIT \(self)")
	}

	init(presenter: DashboardPresenterProtocol, router: DashboardRouterProtocol) {

		self.presenter = presenter
		self.router = router
	}
}

extension DashboardInteractor: DashboardInteractorProtocol {

	func viewDidLoad() {

		presenter.creditScoreWillLoad()

		NetworkRequest.getCreditScore { [weak self] result in

			DispatchQueue.main.async {
				switch result {
				case .success(let creditScoreResponse):
					self?.presenter.creditScoreDidLoad(score: creditScoreResponse)
				case .failure(let error):
					print(error)
				}
			}
		}
	}
}
