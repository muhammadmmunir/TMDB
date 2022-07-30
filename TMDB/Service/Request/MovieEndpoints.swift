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

// FIXME: - DELETE SOON
protocol MovieSearchServiceInterface {
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

public struct MovieSearchService: MovieSearchServiceInterface {
    
    private let request: MoviesRequestDTO
    private let transferService: DataTransferServiceInterface
    
    init(
        request: MoviesRequestDTO,
        transferService: DataTransferServiceInterface
    ) {
        self.request = request
        self.transferService = transferService
    }
    
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = MovieEndpoints.getMovies(
            with: self.request, and: .search)
        let task = self.transferService.request(
            with: endpoint
        ) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toEntity()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
