//
//  TVShowResponseDTO.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

// MARK: - DTO
struct TVShowResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case tvShows = "results"
    }
    let page: Int
    let totalPages: Int
    let tvShows: [TVShowDTO]
}

extension TVShowResponseDTO {
    struct TVShowDTO: Decodable {
        let id: Int
        let name: String?
        let posterPath: String?
        let backdropPath: String?
        let overview: String?
        let firstAirDate: String?
        let voteAverage: Double?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case backdropPath = "backdrop_path"
            case posterPath = "poster_path"
            case overview
            case firstAirDate = "first_air_date"
            case voteAverage = "vote_average"
        }
    }
}

// MARK: - Mapping to Entity
extension TVShowResponseDTO {
    func toEntity() -> TVShowsPage {
        return .init(
            page: self.page,
            totalPages: self.totalPages,
            tvShows: self.tvShows.map { $0.toEntity() }
        )
    }
}

extension TVShowResponseDTO.TVShowDTO {
    func toEntity() -> TVShow {
        return .init(
            id: self.id,
            posterPath: self.posterPath,
            backdropPath: self.backdropPath,
            overview: self.overview,
            voteAverage: self.voteAverage,
            name: self.name ?? "",
            firstAirDate: self.firstAirDate
        )
    }
}
