//
//  MockDispatchQueue.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation
@testable import Clear

class MockDispatchQueue: DispatchQueueProtocol {

	func async(execute workItem: DispatchWorkItem) {
		workItem.perform()
	}
}
