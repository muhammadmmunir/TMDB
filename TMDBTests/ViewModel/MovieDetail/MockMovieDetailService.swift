//
//  MockMovieDetailService.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

@testable import TMDB

final class MockMovieDetailService: MovieDetailServiceInterface {
    var movieRequest: ReviewRequestDTO = .init(query: "", page: 1)
    var tvShowRequest: ReviewRequestDTO = .init(query: "", page: 1)
    
    var fetchMovieReviewStatus: Bool = true
    var fetchTVShowReviewStatus: Bool = true
    var reviewPage = ReviewsPage(page: 1, totalPages: 1, reviews: [])
    
    func fetchMovieReviewsList(
        movieId: Int,
        completion: @escaping (Result<ReviewsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchMovieReviewStatus {
            completion(.success(self.reviewPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchTVShowReviewsList(
        tvShowId: Int, completion: @escaping (Result<ReviewsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchTVShowReviewStatus {
            completion(.success(self.reviewPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
}
