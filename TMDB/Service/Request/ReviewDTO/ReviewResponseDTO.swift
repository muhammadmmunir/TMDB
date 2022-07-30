//
//  ReviewResponseDTO.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

// MARK: - DTO
struct ReviewResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case reviews = "results"
    }
    let page: Int
    let totalPages: Int
    let reviews: [ReviewDTO]
}

extension ReviewResponseDTO {
    struct ReviewDTO: Decodable {
        let id: String
        var content: String?
        var authorDetails: AuthorDetailsDTO?
        
        private enum CodingKeys: String, CodingKey {
            case id, content
            case authorDetails = "author_details"
        }
        
        struct AuthorDetailsDTO: Decodable {
            var name: String?
            var avatarPath: String?
            
            private enum CodingKeys: String, CodingKey {
                case name
                case avatarPath = "avatar_path"
            }
        }
    }
}

// MARK: - Mapping to Entity
extension ReviewResponseDTO {
    func toEntity() -> ReviewsPage {
        return .init(
            page: self.page,
            totalPages: self.totalPages,
            reviews: self.reviews.map { $0.toEntity() })
    }
}

extension ReviewResponseDTO.ReviewDTO {
    func toEntity() -> Review {
        return .init(
            id: self.id,
            name: self.authorDetails?.name,
            avatarPath: self.authorDetails?.avatarPath,
            content: self.content)
    }
}
