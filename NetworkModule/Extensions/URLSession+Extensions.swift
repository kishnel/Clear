//
//  URLSession+Extensions.swift
//  NetworkModule
//
//  Created by Marcello Mascia on 15/12/2021.
//

import Foundation

extension URLSession: NetworkSession {

	public func fetch(request: URLRequest, completion: @escaping (NetworkResult) -> Void) {

		let task = dataTask(with: request) { data, _, error in

			do {
				if let error = error { throw error }
				guard let data = data else { throw NetworkRequestError.sessionDataNotAvailable }

				completion(.success(data))

			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
}
