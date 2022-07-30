//
//  SearchViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import Combine

class SearchViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var searchText = ""
    @Published var items = [[MovieBase]]()
    @Published var state: State = .initial
    
    private var searchTask: APIServiceCancellableInterface? {
        willSet {
            self.searchTask?.cancel()
        }
    }
    
    init() {
        self.fetch()
    }
    
    func mapMoviesPage(_ moviesPage: MoviesPage) -> [[Movie]] {
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
    
    private func fetch() {
        let request = MoviesRequestDTO(query: "Thor", page: 1)
        let apiServiceConfig = APIServiceConfig(
            baseURL: APIConfig.baseURL,
            headers: [:],
            queryParams: ["api_key": APIConfig.apiKey])
        let apiService = APIService(config: apiServiceConfig)
        let transferService = DataTransferService(apiService: apiService)
        let service = MovieSearchService(request: request, transferService: transferService)
        
        self.state = .loading
        self.searchTask = service.fetchMoviesList { result in
            switch result {
            case .success(let moviesPage):
                self.items = self.mapMoviesPage(moviesPage)
                self.state = .data
            case .failure:
                self.state = .error
            }
            self.searchTask = nil
        }
    }
}
