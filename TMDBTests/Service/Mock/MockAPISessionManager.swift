//
//  MockAPISessionManager.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation
@testable import TMDB

struct MockAPISessionManager: APISessionManagerInterface {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(
        _ request: URLRequest,
        completion: @escaping CompletionHandler
    ) -> APIServiceCancellableInterface {
        completion(data, response, error)
        return URLSession.shared.dataTask(with: URL(string: "https://api.test.com")!)
    }
}
