//
//  SearchViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import Foundation
import Combine

protocol SearchViewModelInterface: ObservableObject {
    var searchText: String { get set }
    var items: [[MovieBase]] { get set }
    var state: APIServiceState { get set }
}

class SearchViewModel: SearchViewModelInterface {
    private var service: SearchServiceInterface
    private var searchTask: APIServiceCancellableInterface? {
        willSet {
            self.searchTask?.cancel()
        }
    }
    private var disposables = Set<AnyCancellable>()
    
    @Published var searchText = ""
    @Published var items = [[MovieBase]]()
    @Published var state: APIServiceState = .initial
    
    init(
        service: SearchServiceInterface = SearchService(transferService: DataTransferService())
    ) {
        self.service = service
        self.bind()
    }
    
    private func bind() {
        self.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { query in
                if !query.isEmpty {
                    self.load(query)
                } else {
                    self.items = []
                }
            }
            .store(in: &self.disposables)
    }
    
    /// Mapping array `[Movie]` to `[[Movie]]`
    private func mapMoviesPage(_ moviesPage: MoviesPage) -> [[Movie]] {
        var movies = moviesPage.movies
        var items = [[Movie]]()
        
        while !movies.isEmpty {
            var itemsInside = [Movie]()
            for _ in 0...2 where !movies.isEmpty {
                itemsInside.append(movies.removeFirst())
            }
            items.append(itemsInside)
        }
        return items
    }
    
    private func load(_ query: String) {
        self.service.request = MoviesRequestDTO(query: query, page: 1)
        self.state = .loading
        self.searchTask = self.service.fetchMoviesList { result in
            switch result {
            case .success(let moviesPage):
                self.items = self.mapMoviesPage(moviesPage)
                self.state = .success
            case .failure:
                self.state = .error
            }
            self.searchTask = nil
        }
    }
}
