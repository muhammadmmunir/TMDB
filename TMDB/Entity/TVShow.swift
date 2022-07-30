//
//  TVShow.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

public class TVShow: MovieBase {
    public let name: String
    public let firstAirDate: String?
    
    public init(
        id: Int,
        posterPath: String?,
        backdropPath: String?,
        overview: String?,
        voteAverage: Double?,
        name: String,
        firstAirDate: String?
    ) {
        self.name = name
        self.firstAirDate = firstAirDate
        super.init(
            id: id,
            posterPath: posterPath,
            backdropPath: backdropPath,
            overview: overview,
            voteAverage: voteAverage
        )
    }
    
    override public func getTitle() -> String {
        self.name
    }
    
    override public func getReleaseDate() -> String? {
        self.firstAirDate
    }
}

public struct TVShowsPage: Equatable {
    public let page: Int
    public let totalPages: Int
    public let tvShows: [TVShow]
}
