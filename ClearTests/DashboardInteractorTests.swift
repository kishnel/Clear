//
//  DashboardInteractorTests.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import XCTest
import NetworkModule
@testable import Clear

private class MockPresenter: DashboardPresenterProtocol {

	private(set) var creditScoreWillLoadDidCall = false
	private(set) var scoreResponse: CreditScoreResponse?
	private(set) var error: Error?

	func creditScoreWillLoad() {

		creditScoreWillLoadDidCall = true
	}

	func creditScoreDidLoad(score: CreditScoreResponse) {

		scoreResponse = score
	}

	func creditScoreDidFail(with error: Error) {

		self.error = error
	}
}

private class MockRouter: DashboardRouterProtocol {

	func showDetail() {

	}
}

class DashboardInteractorTests: XCTestCase {

	override func setUpWithError() throws {

	}

	override func tearDownWithError() throws {

	}

	func testViewDidLoad_Error() throws {

		let presenter = MockPresenter()
		let router = MockRouter()
		let session = MockSession(result: .failure(NSError.mockError))
		let interactor = DashboardInteractor(presenter: presenter, router: router, session: session)

		XCTAssertFalse(presenter.creditScoreWillLoadDidCall)

		interactor.viewDidLoad()

		XCTAssertTrue(presenter.creditScoreWillLoadDidCall)
		XCTAssertEqual(presenter.error?.localizedDescription, NSError.mockError.localizedDescription)
	}

	func testViewDidLoad_Success() throws {

		let jsonFileURL = Bundle(for: Self.self).url(forResource: "creditScore", withExtension: "json")
		let data = try Data(contentsOf: jsonFileURL!)
		let presenter = MockPresenter()
		let router = MockRouter()
		let session = MockSession(result: .success(data))
		let interactor = DashboardInteractor(presenter: presenter, router: router, session: session)

		XCTAssertFalse(presenter.creditScoreWillLoadDidCall)

		interactor.viewDidLoad()

		XCTAssertTrue(presenter.creditScoreWillLoadDidCall)
		XCTAssertNil(presenter.error)
		XCTAssertEqual(presenter.scoreResponse?.creditReportInfo.score, 514)
	}
}
