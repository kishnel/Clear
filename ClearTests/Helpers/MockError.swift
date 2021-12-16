//
//  MockError.swift
//  ClearTests
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation

extension NSError {
	static let mockError = NSError(domain: "clear.tests", code: 666, userInfo: nil)
}
