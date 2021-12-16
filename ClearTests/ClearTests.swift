//
//  ClearTests.swift
//  ClearTests
//
//  Created by Marcello Mascia on 15/12/2021.
//

import XCTest
import NetworkModule
@testable import Clear

class ClearTests: XCTestCase {

    override func setUpWithError() throws {

	}

    override func tearDownWithError() throws {

	}

	func testCreditScoreRequest_Error() throws {

		let session = MockSession(result: .failure(NSError.mockError))
		NetworkRequest.getCreditScore(session: session) { result in

			switch result {
			case .success:
				XCTFail("Expecting an error for this test")
			case .failure(let error):
				XCTAssertEqual(error.localizedDescription, NSError.mockError.localizedDescription)
			}
		}
	}

	func testCreditScoreRequest_DecodingError() throws {

		let session = MockSession(result: .success("".data(using: .utf8)!))
		NetworkRequest.getCreditScore(session: session) { result in

			switch result {
			case .success:
				XCTFail("Expecting an error for this test")
			case .failure(let error):
				XCTAssertNotNil(error as? DecodingError)
			}
		}
	}

	func testCreditScoreRequest_Success() throws {

		let jsonFileURL = Bundle(for: Self.self).url(forResource: "creditScore", withExtension: "json")
		let data = try Data(contentsOf: jsonFileURL!)

		let session = MockSession(result: .success(data))
		NetworkRequest.getCreditScore(session: session) { result in

			switch result {
			case .success(let response):
				XCTAssertEqual(response.accountIDVStatus, "PASS")
				XCTAssertEqual(response.creditReportInfo.daysUntilNextReport, 9)
				XCTAssertEqual(response.creditReportInfo.maxScoreValue, 700)
				XCTAssertEqual(response.creditReportInfo.minScoreValue, 0)
				XCTAssertEqual(response.creditReportInfo.score, 514)
			case .failure(let error):
				XCTFail("Expecting a success for this test. Error: \(error.localizedDescription)")
			}
		}
	}
}
