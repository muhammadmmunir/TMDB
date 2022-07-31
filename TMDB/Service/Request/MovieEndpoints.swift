//
//  MovieEndpoints.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

struct MovieEndpoints {
    static func getMovies(
        with request: MoviesRequestDTO,
        and path: APIPath.Movie
    ) -> APIEndpoint<MoviesResponseDTO> {
        return APIEndpoint(
            path: path.rawValue,
            method: .get,
            queryParametersEncodable: request
        )
    }
    
    static func getMovieReviews(
        with request: ReviewRequestDTO,
        and movieId: Int
    ) -> APIEndpoint<ReviewResponseDTO> {
        return APIEndpoint(
            path: APIPath.Movie
                .reviews.rawValue
                .replacingOccurrences(of: "{movie_id}", with: "\(movieId)"),
            method: .get,
            queryParametersEncodable: request
        )
    }
}
