//
//  DashboardPresenterTests.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import XCTest
@testable import Clear

private class MockView: DashboardViewProtocol {

	var updateState: DashboardState?

	func update(state: DashboardState) {

		updateState = state
	}
}

class DashboardPresenterTests: XCTestCase {

	private var view: MockView!

    override func setUpWithError() throws {

		view = MockView()
    }

    override func tearDownWithError() throws {

		view = nil
    }

    func testInitialState() throws {

		let presenter = DashboardPresenter()
		presenter.view = view

		XCTAssertEqual(view.updateState, nil)
    }

	func testLoadingState() throws {

		let presenter = DashboardPresenter()
		presenter.view = view
		presenter.creditScoreWillLoad()

		XCTAssertEqual(view.updateState, .loading)
	}

	func testErrorState() throws {

		let presenter = DashboardPresenter(dispatchQueue: MockDispatchQueue())
		presenter.view = view
		presenter.creditScoreDidFail(with: NSError.mockError)

		XCTAssertEqual(view.updateState, .error)
	}

	func testDataState() throws {

		let presenter = DashboardPresenter(dispatchQueue: MockDispatchQueue())
		presenter.view = view

		let creditScore = CreditScoreResponse(
			accountIDVStatus: "TEST",
			creditReportInfo: .init(
				score: 10,
				maxScoreValue: 100,
				minScoreValue: 0,
				daysUntilNextReport: 12
			)
		)
		presenter.creditScoreDidLoad(score: creditScore)

		let expectedViewModel = DashboardViewModel(boxTitle: "Your credit score is", boxValue: "10", boxSubtitle: "out of 100")
		XCTAssertEqual(view.updateState, .box(expectedViewModel))
	}
}
