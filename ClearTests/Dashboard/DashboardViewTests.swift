//
//  DashboardViewTests.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import XCTest
@testable import Clear

private class MockInteractor: DashboardInteractorProtocol {

	private(set) var viewDidLoadDidCall = false
	private(set) var retryButtonDidTapDidCall = false
	private(set) var boxDidTapDidCall = false

	func viewDidLoad() {

		viewDidLoadDidCall = true
	}

	func retryButtonDidTap() {

		retryButtonDidTapDidCall = true
	}

	func boxDidTap() {

		boxDidTapDidCall = true
	}
}

class DashboardViewTests: XCTestCase {

	private var view: DashboardViewController!
	private var interactor: MockInteractor!

    override func setUpWithError() throws {

		interactor = MockInteractor()

		view = DashboardViewController(interactor: interactor)
		view.circleView = .init()
		view.activityIndicator = .init()
		view.boxTitleLabel = .init()
		view.boxValueLabel = .init()
		view.boxSubtitleLabel = .init()
		view.errorLabel = .init()
		view.errorContainer = .init()
		view.errorButton = .init()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewDidLoad() throws {

		view.viewDidLoad()

		XCTAssertTrue(interactor.viewDidLoadDidCall)
		XCTAssertEqual(view.title, "Dashboard")
		XCTAssertEqual(view.boxTitleLabel.textColor, .label)
		XCTAssertEqual(view.boxValueLabel.textColor, .systemYellow)
		XCTAssertEqual(view.boxSubtitleLabel.textColor, .label)
		XCTAssertEqual(view.circleView.backgroundColor, .secondarySystemBackground)
		XCTAssertEqual(view.errorButton.title(for: .normal), "Retry")
	}

	func testViewStateChange_Loading() throws {

		view.update(state: .loading)

		XCTAssertTrue(view.activityIndicator.isAnimating)
		XCTAssertTrue(view.circleView.isHidden)
	}

	func testViewStateChange_Box() throws {

		view.update(state: .box(.init(boxTitle: "A title", boxValue: "A value", boxSubtitle: "A subtitle")))

		XCTAssertFalse(view.activityIndicator.isAnimating)
		XCTAssertFalse(view.circleView.isHidden)
		XCTAssertEqual(view.boxTitleLabel.text, "A title")
		XCTAssertEqual(view.boxValueLabel.text, "A value")
		XCTAssertEqual(view.boxSubtitleLabel.text, "A subtitle")
	}

	func testViewStateChange_Error() throws {

		view.viewDidLoad()
		view.update(state: .error("An error message"))

		XCTAssertFalse(view.activityIndicator.isAnimating)
		XCTAssertTrue(view.circleView.isHidden)
		XCTAssertEqual(view.errorLabel.text, "An error message")
	}

	func testRetryButton() throws {

		view.retryButtonDidTap(.init())

		XCTAssertTrue(interactor.retryButtonDidTapDidCall)
	}

	func testBoxTap() throws {

		view.boxDidTap(.init())

		XCTAssertTrue(interactor.boxDidTapDidCall)
	}
}
