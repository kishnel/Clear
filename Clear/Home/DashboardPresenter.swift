//
//  DashboardPresenter.swift
//  Clear
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation

protocol DashboardPresenterProtocol: AnyObject {

	func creditScoreWillLoad()
	func creditScoreDidLoad(score: CreditScoreResponse)
}

class DashboardPresenter {

	weak var view: DashboardViewProtocol?

	deinit {
		print("DEINIT \(self)")
	}
}

extension DashboardPresenter: DashboardPresenterProtocol {

	func creditScoreWillLoad() {

		view?.update(state: .loading)
	}

	func creditScoreDidLoad(score: CreditScoreResponse) {

		let viewModel = DashboardViewController.ViewModel(
			boxTitle: "Your credit score is",
			boxValue: "\(score.creditReportInfo.score)",
			boxSubtitle: "out of \(score.creditReportInfo.maxScoreValue)"
		)
		view?.update(state: .box(viewModel))
	}
}
