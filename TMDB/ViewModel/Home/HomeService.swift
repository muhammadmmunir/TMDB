//
//  HomeService.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol HomeServiceInterface {
    var moviesRequest: MoviesRequestDTO { get set }
    func fetchMovieNowPlayingList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    func fetchMovieTrendingList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    func fetchMovieDiscoverList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    
    var tvShowsRequest: TVShowRequestDTO { get set }
    func fetchTVShowNowPlayingList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    func fetchTVShowTrendingList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    func fetchTVShowDiscoverList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

final class HomeService {
    var moviesRequest: MoviesRequestDTO
    var tvShowsRequest: TVShowRequestDTO
    private let transferService: DataTransferServiceInterface
    
    init(
        moviesRequest: MoviesRequestDTO = .init(query: "", page: 1),
        tvShowsRequest: TVShowRequestDTO = .init(query: "", page: 1),
        transferService: DataTransferServiceInterface = DataTransferService()
    ) {
        self.moviesRequest = moviesRequest
        self.tvShowsRequest = tvShowsRequest
        self.transferService = transferService
    }
}

extension HomeService: HomeServiceInterface {
    // MARK: - Movies
    func fetchMovieNowPlayingList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = MovieEndpoints.getMovies(with: self.moviesRequest, and: .nowPlaying)
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
    
    func fetchMovieTrendingList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = MovieEndpoints.getMovies(with: self.moviesRequest, and: .trending)
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
    
    func fetchMovieDiscoverList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = MovieEndpoints.getMovies(with: self.moviesRequest, and: .discover)
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
    
    // MARK: - TV Show
    func fetchTVShowNowPlayingList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = TVShowEndpoints.getTVShows(with: self.tvShowsRequest, and: .nowPlaying)
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
    
    func fetchTVShowTrendingList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = TVShowEndpoints.getTVShows(with: self.tvShowsRequest, and: .trending)
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
    
    func fetchTVShowDiscoverList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        let endpoint = TVShowEndpoints.getTVShows(with: self.tvShowsRequest, and: .discover)
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
