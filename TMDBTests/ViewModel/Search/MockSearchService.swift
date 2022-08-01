//
//  MockSearchService.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

@testable import TMDB

final class MockSearchService: SearchServiceInterface {
    var movieRequest: MoviesRequestDTO = .init(query: "", page: 1)
    var tvShowRequest: TVShowRequestDTO = .init(query: "", page: 1)
    
    var moviesPage: MoviesPage = .init(page: 1, totalPages: 1, movies: [])
    var fetchMovieStatus: Bool = true
    var tvShowsPage: TVShowsPage = .init(page: 1, totalPages: 1, tvShows: [])
    var fetchTVShowStatus: Bool = true
    
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchMovieStatus {
            completion(.success(self.moviesPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchTVShowList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchTVShowStatus {
            completion(.success(self.tvShowsPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
}
