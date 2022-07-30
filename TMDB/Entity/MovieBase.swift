//
//  MovieBase.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

public class MovieBase: Identifiable {
    public let id: Int
    public var posterPath: String?
    public var backdropPath: String?
    public var overview: String?
    public var voteAverage: Double?
    
    init(
        id: Int,
        posterPath: String?,
        backdropPath: String?,
        overview: String?,
        voteAverage: Double?
    ) {
        self.id = id
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
        self.voteAverage = voteAverage
    }
    
    public var posterURL: URL? {
        guard let posterPath = self.posterPath else {
            return nil
        }
        return URL(string: APIConfig.baseImageURL + "w500" + posterPath)
    }
    public var backdropURL: URL? {
        guard let backdropPath = self.backdropPath else {
            return nil
        }
        return URL(string: APIConfig.baseImageURL + "w780" + backdropPath)
    }
    
    public func getTitle() -> String {
        return ""
    }
    
    public func getReleaseDate() -> String? {
        return nil
    }
}

extension MovieBase: Equatable {
    public static func == (lhs: MovieBase, rhs: MovieBase) -> Bool {
        return lhs.id == rhs.id &&
        lhs.posterPath == rhs.posterPath &&
        lhs.backdropPath == rhs.backdropPath &&
        lhs.overview == rhs.overview &&
        lhs.voteAverage == rhs.voteAverage &&
        lhs.getTitle() == rhs.getTitle() &&
        lhs.getReleaseDate() == rhs.getReleaseDate()
    }
}
