//
//  Review.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

public struct Review: Equatable, Identifiable {
    public let id: String
    public var name: String?
    public var avatarPath: String?
    public var content: String?
    
    public var avatarURL: URL? {
        guard let avatarPath = self.avatarPath else {
            return nil
        }
        return URL(string: APIConfig.baseImageURL + "w92" + avatarPath)
    }
}

public struct ReviewsPage: Equatable {
    public let page: Int
    public let totalPages: Int
    public let reviews: [Review]
}
