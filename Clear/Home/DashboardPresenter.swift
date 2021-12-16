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
	func creditScoreDidFail(with error: Error)
}

class DashboardPresenter {

	weak var view: DashboardViewProtocol?

	private let dispatchQueue: DispatchQueueProtocol

	deinit {
		print("DEINIT \(self)")
	}

	init(dispatchQueue: DispatchQueueProtocol = DispatchQueue.main) {

		self.dispatchQueue = dispatchQueue
	}
}

extension DashboardPresenter: DashboardPresenterProtocol {

	func creditScoreWillLoad() {

		view?.update(state: .loading)
	}

	func creditScoreDidLoad(score: CreditScoreResponse) {

		let viewModel = DashboardViewModel(
			boxTitle: NSLocalizedString("Your credit score is", comment: "Dashboard box descriptive title"),
			boxValue: "\(score.creditReportInfo.score)",
			boxSubtitle: String(format: NSLocalizedString("out of %d", comment: "Dashboard box formatted subtitle"), score.creditReportInfo.maxScoreValue)
		)

		dispatchQueue.async(execute: DispatchWorkItem {
			self.view?.update(state: .box(viewModel))
		})
	}

	func creditScoreDidFail(with: Error) {

		dispatchQueue.async(execute: DispatchWorkItem {
			self.view?.update(state: .error)
		})
	}
}
