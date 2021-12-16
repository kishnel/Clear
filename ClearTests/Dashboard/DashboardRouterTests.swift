//
//  DashboardRouterTests.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import XCTest
@testable import Clear

class DashboardRouterTests: XCTestCase {

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testBuild() throws {

		let navController = UINavigationController()
		let router = DashboardRouter(navigationController: navController)
		router.build()

		XCTAssertEqual(navController.viewControllers.count, 1)
		XCTAssertTrue(navController.viewControllers.first is DashboardViewController)
	}

	func testShowDetail() throws {

		let navController = UINavigationController()
		let router = DashboardRouter(navigationController: navController)
		router.build()

		XCTAssertEqual(navController.viewControllers.count, 1)
		XCTAssertTrue(navController.viewControllers.first is DashboardViewController)

		router.showDetail(animated: false)

		XCTAssertEqual(navController.viewControllers.count, 2)
		XCTAssertTrue(navController.viewControllers.first is DashboardViewController)
	}
}
