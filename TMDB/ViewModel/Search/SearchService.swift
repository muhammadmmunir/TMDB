//
//  SearchService.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol SearchServiceInterface {
    var request: MoviesRequestDTO { get set }
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface?
}

final class SearchService {
    var request: MoviesRequestDTO
    private let transferService: DataTransferServiceInterface
    
    init(
        request: MoviesRequestDTO = .init(query: "One Piece", page: 1),
        transferService: DataTransferServiceInterface
    ) {
        self.request = request
        self.transferService = transferService
    }
}

extension SearchService: SearchServiceInterface {
    func fetchMoviesList(
        completion: @escaping (Result<MoviesPage, Error>) -> Void
    ) -> APIServiceCancellableInterface? {
        
        let endpoint = MovieEndpoints.getMovies(with: self.request, and: .search)
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
