//
//  MockAPIServiceConfig.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

@testable import TMDB

class MockAPIServiceConfig: APIServiceConfigInterface {
    var baseURL: String = "https://api.test.com"
    var headers: [String : String] = [:]
    var queryParams: [String : String] = [:]
}
