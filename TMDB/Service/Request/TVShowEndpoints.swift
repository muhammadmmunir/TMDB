//
//  TVShowEndpoints.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

struct TVShowEndpoints {
    static func getTVShows(
        with request: TVShowRequestDTO,
        and path: APIPath.TVShow
    ) -> APIEndpoint<TVShowResponseDTO> {
        return APIEndpoint(
            path: path.rawValue,
            method: .get,
            queryParametersEncodable: request
        )
    }
    
    static func getMovieReviews(
        with request: ReviewRequestDTO,
        and tvId: Int
    ) -> APIEndpoint<ReviewResponseDTO> {
        return APIEndpoint(
            path: APIPath.TVShow
                .reviews.rawValue
                .replacingOccurrences(of: "{tv_id}", with: "\(tvId)"),
            method: .get,
            queryParametersEncodable: request
        )
    }
}
