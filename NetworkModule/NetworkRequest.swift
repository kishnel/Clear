//
//  NetworkRequest.swift
//  NetworkModule
//
//  Created by Marcello Mascia on 15/12/2021.
//

import Foundation

enum NetworkRequestError: Error {
	case sessionDataNotAvailable
}

public typealias NetworkResult = Result<Data, Error>

public protocol NetworkSession {

	func fetch(request: URLRequest, completion: @escaping (NetworkResult) -> Void)
}

public final class NetworkRequest {

	public enum Method: String {
		case post
		case get
	}

	private let url: URL
	private let method: Method
	private let session: NetworkSession

	public init(url: URL, method: Method = .get, session: NetworkSession = URLSession.shared) {

		self.url = url
		self.method = method
		self.session = session
	}

	public func perform(timeout: TimeInterval = 60, completion: @escaping (NetworkResult) -> Void) {

		var request = URLRequest(url: url, timeoutInterval: timeout)
		request.httpMethod = method.rawValue.uppercased()

		session.fetch(request: request, completion: completion)
	}
}
