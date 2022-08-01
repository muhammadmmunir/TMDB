//
//  MockHomeService.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

@testable import TMDB

final class MockHomeService: HomeServiceInterface {
    var moviesRequest: MoviesRequestDTO = .init(query: "", page: 1)
    var tvShowsRequest: TVShowRequestDTO = .init(query: "", page: 1)
    
    var nowPlayingMoviesPage = MoviesPage(page: 1, totalPages: 1, movies: [])
    var fetchMovieNowPlayingSuccess = true
    var trendingMoviesPage = MoviesPage(page: 1, totalPages: 1, movies: [])
    var fetchMovieTrendingSuccess = true
    var discoverMoviesPage = MoviesPage(page: 1, totalPages: 1, movies: [])
    var fetchMovieDiscoverSuccess = true
    
    var nowPlayingTvShowsPage = TVShowsPage(page: 1, totalPages: 1, tvShows: [])
    var fetchTVShowNowPlayingSuccess = true
    var trendingTvShowsPage = TVShowsPage(page: 1, totalPages: 1, tvShows: [])
    var fetchTVShowTrendingSuccess = true
    var discoverTvShowsPage = TVShowsPage(page: 1, totalPages: 1, tvShows: [])
    var fetchTVShowDiscoverSuccess = true
    
    func fetchMovieNowPlayingList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchMovieNowPlayingSuccess {
            completion(.success(self.nowPlayingMoviesPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchMovieTrendingList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchMovieTrendingSuccess {
            completion(.success(self.trendingMoviesPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchMovieDiscoverList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchMovieDiscoverSuccess {
            completion(.success(self.discoverMoviesPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchTVShowNowPlayingList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchTVShowNowPlayingSuccess {
            completion(.success(self.nowPlayingTvShowsPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchTVShowTrendingList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchTVShowTrendingSuccess {
            completion(.success(self.trendingTvShowsPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
    
    func fetchTVShowDiscoverList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        if self.fetchTVShowDiscoverSuccess {
            completion(.success(self.discoverTvShowsPage))
        } else {
            completion(.failure(DataTransferError.noResponse))
        }
        return nil
    }
}
