//
//  SearchService.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol SearchServiceInterface {
    var movieRequest: MoviesRequestDTO { get set }
    var tvShowRequest: TVShowRequestDTO { get set }
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
    func fetchTVShowList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

final class SearchService {
    var movieRequest: MoviesRequestDTO
    var tvShowRequest: TVShowRequestDTO
    private let transferService: DataTransferServiceInterface
    
    init(
        movieRequest: MoviesRequestDTO = .init(query: "One Piece", page: 1),
        tvShowRequest: TVShowRequestDTO = .init(query: "One Piece", page: 1),
        transferService: DataTransferServiceInterface = DataTransferService()
    ) {
        self.movieRequest = movieRequest
        self.tvShowRequest = tvShowRequest
        self.transferService = transferService
    }
}

extension SearchService: SearchServiceInterface {
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        
        let endpoint = MovieEndpoints.getMovies(with: self.movieRequest, and: .search)
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
    
    func fetchTVShowList(
        completion: @escaping (Result<TVShowsPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        
        let endpoint = TVShowEndpoints.getTVShows(with: self.tvShowRequest, and: .search)
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
