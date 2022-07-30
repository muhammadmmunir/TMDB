//
//  Movie.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

public class Movie: MovieBase {
    public let title: String
    public let releaseDate: String?
    
    public init(
        id: Int,
        posterPath: String?,
        backdropPath: String?,
        overview: String?,
        voteAverage: Double?,
        title: String,
        releaseDate: String?
    ) {
        self.title = title
        self.releaseDate = releaseDate
        super.init(
            id: id,
            posterPath: posterPath,
            backdropPath: backdropPath,
            overview: overview,
            voteAverage: voteAverage
        )
    }
    
    override public func getTitle() -> String {
        self.title
    }
    
    override public func getReleaseDate() -> String? {
        self.releaseDate
    }
}

public struct MoviesPage: Equatable {
    public let page: Int
    public let totalPages: Int
    public let movies: [Movie]
}
