//
//  MovieDetailService.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol MovieDetailServiceInterface {
    var movieRequest: ReviewRequestDTO { get set }
    var tvShowRequest: ReviewRequestDTO { get set }
    func fetchMovieReviewsList(
        movieId: Int,
        completion: @escaping (Result<ReviewsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    func fetchTVShowReviewsList(
        tvShowId: Int,
        completion: @escaping (Result<ReviewsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

final class MovieDetailService {
    var movieRequest: ReviewRequestDTO
    var tvShowRequest: ReviewRequestDTO
    private let transferService: DataTransferServiceInterface
    
    init(
        movieRequest: ReviewRequestDTO = .init(query: "", page: 1),
        tvShowRequest: ReviewRequestDTO = .init(query: "", page: 1),
        transferService: DataTransferServiceInterface = DataTransferService()
    ) {
        self.movieRequest = movieRequest
        self.tvShowRequest = tvShowRequest
        self.transferService = transferService
    }
}

extension MovieDetailService: MovieDetailServiceInterface {
    func fetchMovieReviewsList(
        movieId: Int,
        completion: @escaping (Result<ReviewsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = MovieEndpoints.getMovieReviews(with: self.movieRequest, and: movieId)
        let task = self.transferService.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toEntity()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    func fetchTVShowReviewsList(
        tvShowId: Int,
        completion: @escaping (Result<ReviewsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = TVShowEndpoints.getTVShowReviews(
            with: self.tvShowRequest, and: tvShowId)
        let task = self.transferService.request(with: endpoint) { result in
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
