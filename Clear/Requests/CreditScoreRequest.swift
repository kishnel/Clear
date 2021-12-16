//
//  CreditScoreRequest.swift
//  NetworkModule
//
//  Created by Marcello Mascia on 15/12/2021.
//

import Foundation
import NetworkModule

public struct CreditScoreResponse: Decodable {

	struct CreditReportInfo: Decodable {
		let score: Int
		let maxScoreValue: Int
		let minScoreValue: Int
		let daysUntilNextReport: Int
	}

	let accountIDVStatus: String
	let creditReportInfo: CreditReportInfo
}

private extension URL {
	static let url = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")!
}

public extension NetworkRequest {

	static func getCreditScore(session: NetworkSession, completion: @escaping (Result<CreditScoreResponse, Error>) -> Void) {

		NetworkRequest(url: .url, method: .get, session: session).perform(timeout: 10) { result in

			switch result {
			case .success(let response):
				do {
					let decoder = JSONDecoder()
					let response = try decoder.decode(CreditScoreResponse.self, from: response)
					completion(.success(response))
				} catch {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
