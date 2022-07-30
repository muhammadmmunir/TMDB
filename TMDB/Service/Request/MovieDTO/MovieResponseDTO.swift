//
//  MovieResponseDTO.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

// MARK: - DTO
struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case movies = "results"
    }
    let page: Int
    let totalPages: Int
    let movies: [MovieDTO]
}

extension MoviesResponseDTO {
    struct MovieDTO: Decodable {
        let id: Int
        let title: String?
        let posterPath: String?
        let backdropPath: String?
        let overview: String?
        let releaseDate: String?
        let voteAverage: Double?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case backdropPath = "backdrop_path"
            case posterPath = "poster_path"
            case overview
            case releaseDate = "release_date"
            case voteAverage = "vote_average"
        }
    }
}

// MARK: - Mapping to Entity
extension MoviesResponseDTO {
    func toEntity() -> MoviesPage {
        return .init(
            page: self.page,
            totalPages: self.totalPages,
            movies: self.movies.map { $0.toEntity() }
        )
    }
}

extension MoviesResponseDTO.MovieDTO {
    func toEntity() -> Movie {
        return .init(
            id: self.id,
            posterPath: self.posterPath,
            backdropPath: self.backdropPath,
            overview: self.overview,
            voteAverage: self.voteAverage,
            title: self.title ?? "",
            releaseDate: self.releaseDate
        )
    }
}
