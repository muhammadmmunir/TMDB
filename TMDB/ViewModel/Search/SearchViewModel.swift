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
    var selectedType: Int { get set }
    var searchPlaceholder: String { get }
}

final class SearchViewModel: SearchViewModelInterface {
    private let wording: Wording
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
    var selectedType: Int = 0
    var searchPlaceholder: String {
        if selectedType == 0 {
            return self.wording.str(.generalSearchMovie)
        } else {
            return self.wording.str(.generalSearchTVShow)
        }
    }
    
    init(
        wording: Wording = .init(),
        service: SearchServiceInterface = SearchService(transferService: DataTransferService())
    ) {
        self.wording = wording
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
    
    /// Mapping array `[TVShow]` to `[[TVShow]]`
    private func mapTVShowsPage(_ tvShowsPage: TVShowsPage) -> [[TVShow]] {
        var tvShows = tvShowsPage.tvShows
        var items = [[TVShow]]()
        
        while !tvShows.isEmpty {
            var itemsInside = [TVShow]()
            for _ in 0...2 where !tvShows.isEmpty {
                itemsInside.append(tvShows.removeFirst())
            }
            items.append(itemsInside)
        }
        return items
    }
    
    private func load(_ query: String) {
        if self.selectedType == 0 {
            self.loadMovie(using: query)
        } else {
            self.loadTVShow(using: query)
        }
    }
    
    private func loadMovie(using query: String) {
        self.service.movieRequest = MoviesRequestDTO(query: query, page: 1)
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
    
    private func loadTVShow(using query: String) {
        self.service.tvShowRequest = TVShowRequestDTO(query: query, page: 1)
        self.state = .loading
        self.searchTask = self.service.fetchTVShowList { result in
            switch result {
            case .success(let tvShowsPage):
                self.items = self.mapTVShowsPage(tvShowsPage)
                self.state = .success
            case .failure:
                self.state = .error
            }
            self.searchTask = nil
        }
    }
}
