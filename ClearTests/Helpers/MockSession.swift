//
//  MockSession.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation
import NetworkModule

class MockSession: NetworkSession {

	let result: NetworkResult

	init(result: NetworkResult) {

		self.result = result
	}

	func fetch(request: URLRequest, completion: @escaping (NetworkResult) -> Void) {

		completion(result)
	}
}
