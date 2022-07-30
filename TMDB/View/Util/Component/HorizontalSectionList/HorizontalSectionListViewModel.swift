//
//  HorizontalSectionListViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import Foundation

class HorizontalSectionListViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }
    
    @Published var movies = [MovieBase]()
    @Published var state: State = .data
    
    init(movies: [MovieBase]) {
        self.movies = movies
    }
}
