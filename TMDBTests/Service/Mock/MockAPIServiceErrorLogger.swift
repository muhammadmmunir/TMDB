//
//  MockAPIServiceErrorLogger.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

import Foundation
@testable import TMDB

final class MockAPIServiceErrorLogger: APIServiceErrorLoggerInterface {
    var loggedErrors: [Error] = []
    func log(request: URLRequest) {}
    func log(responseData data: Data?, response: URLResponse?) {}
    func log(error: Error) {
        self.loggedErrors.append(error)
    }
}
