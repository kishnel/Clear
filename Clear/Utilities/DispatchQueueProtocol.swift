//
//  DispatchQueueProtocol.swift
//  Clear
//
//  Created by Marcello Mascia on 16/12/2021.
//

import Foundation

protocol DispatchQueueProtocol {
	func async(execute workItem: DispatchWorkItem)
}

extension DispatchQueue: DispatchQueueProtocol { }
