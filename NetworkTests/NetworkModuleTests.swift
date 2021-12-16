//
//  NetworkModuleTests.swift
//  NetworkModuleTests
//
//  Created by Marcello Mascia on 15/12/2021.
//

import XCTest
@testable import NetworkModule

private extension NSError {
	static let mockError = NSError(domain: "networkModule.tests", code: 666, userInfo: nil)
}

private extension URL {
	static let mockURL = URL(string: "http://www.test.com")!
}

private class MockSession: NetworkSession {

	let result: NetworkResult

	init(result: NetworkResult) {

		self.result = result
	}

	func fetch(request: URLRequest, completion: @escaping (NetworkResult) -> Void) {

		completion(result)
	}
}

class NetworkModuleTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testNetworkRequest_Error() throws {

		let session = MockSession(result: .failure(NSError.mockError))
		NetworkRequest(url: .mockURL, session: session).perform { result in

			switch result {
			case .success:
				XCTFail("Expecting an error for this test")
			case .failure(let error):
				XCTAssertEqual(error.localizedDescription, NSError.mockError.localizedDescription)
			}
		}
    }

	func testNetworkRequest_Success() throws {

		let session = MockSession(result: .success("Hello".data(using: .utf8)!))
		NetworkRequest(url: .mockURL, session: session).perform { result in

			switch result {
			case .success(let data):
				XCTAssertEqual(String(data: data, encoding: .utf8), "Hello")
			case .failure(let error):
				XCTFail("Expecting a success for this test. Error: \(error.localizedDescription)")
			}
		}
	}
}
