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
	func retryButtonDidTap()
	func boxDidTap()
}

class DashboardInteractor {

	private let presenter: DashboardPresenterProtocol
	private let router: DashboardRouterProtocol
	private let session: NetworkSession

	init(presenter: DashboardPresenterProtocol, router: DashboardRouterProtocol, session: NetworkSession = URLSession.shared) {

		self.presenter = presenter
		self.router = router
		self.session = session
	}

	private func getCreditScore() {

		presenter.creditScoreWillLoad()

		NetworkRequest.getCreditScore(session: session) { [weak self] result in

			switch result {
			case .success(let creditScoreResponse):
				self?.presenter.creditScoreDidLoad(score: creditScoreResponse)
			case .failure(let error):
				self?.presenter.creditScoreDidFail(with: error)
			}
		}
	}
}

extension DashboardInteractor: DashboardInteractorProtocol {

	func viewDidLoad() {

		getCreditScore()
	}

	func retryButtonDidTap() {

		getCreditScore()
	}

	func boxDidTap() {

		router.showDetail(animated: true)
	}
}
