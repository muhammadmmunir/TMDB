//
//  HorizontalSectionListViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let poster: String?
    
    var posterUrl: URL? {
        guard let posterPath = self.poster else {
            return nil
        }
        return URL(string: posterPath)
    }
}

class HorizontalSectionListViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }
    
    @Published var movies = [Movie]()
    @Published var state: State = .data
    
    init(movies: [Movie]) {
        self.movies = movies
    }
}
