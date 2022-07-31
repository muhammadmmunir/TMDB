//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation
import Combine

protocol HomeViewModelInterface: ObservableObject {
    var trendingTitle: String { get }
    var discoverTitle: String { get }
    var selectedType: Int { get set }
    var nowPlayingItems: [MovieBase] { get set }
    var nowPlayingState: APIServiceState { get set }
    var trendingItems: [MovieBase] { get set }
    var trendingState: APIServiceState { get set }
    var discoverItems: [MovieBase] { get set }
    var discoverState: APIServiceState { get set }
}

final class HomeViewModel: HomeViewModelInterface {
    var trendingTitle: String {
        self.wording.str(.generalTrending)
    }
    var discoverTitle: String {
        self.wording.str(.generalDiscover)
    }
    
    @Published var selectedType: Int = 0
    @Published var nowPlayingItems = [MovieBase]()
    @Published var nowPlayingState: APIServiceState = .initial
    @Published var trendingItems = [MovieBase]()
    @Published var trendingState: APIServiceState = .initial
    @Published var discoverItems = [MovieBase]()
    @Published var discoverState: APIServiceState = .initial
    
    private var nowPlayingTask: APIServiceCancellableInterface? {
        willSet {
            self.nowPlayingTask?.cancel()
        }
    }
    private var trendingTask: APIServiceCancellableInterface? {
        willSet {
            self.trendingTask?.cancel()
        }
    }
    private var discoverTask: APIServiceCancellableInterface? {
        willSet {
            self.discoverTask?.cancel()
        }
    }
    
    private let wording: Wording
    private let service: HomeServiceInterface
    private var disposables = Set<AnyCancellable>()
    
    init(
        selectedType: Int = 0,
        wording: Wording = .init(),
        service: HomeServiceInterface = HomeService()
    ) {
        self.selectedType = selectedType
        self.wording = wording
        self.service = service
        self.bind()
    }
    
    private func bind() {
        self.$selectedType
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                self.load()
            }
            .store(in: &self.disposables)
    }
    
    private func load() {
        if self.selectedType == 0 {
            self.loadMovies()
        } else {
            self.loadTVShows()
        }
    }
    
    private func loadMovies() {
        self.nowPlayingTask?.cancel()
        self.trendingTask?.cancel()
        self.discoverTask?.cancel()
        
        self.loadMovieNowPlaying()
        self.loadMovieTrending()
        self.loadMovieDiscover()
    }
    
    private func loadTVShows() {
        self.nowPlayingTask?.cancel()
        self.trendingTask?.cancel()
        self.discoverTask?.cancel()
        
        self.loadTVShowNowPlaying()
        self.loadTVShowTrending()
        self.loadTVShowDiscover()
    }
    
    // MARK: - Movies
    private func loadMovieNowPlaying() {
        self.nowPlayingState = .loading
        self.nowPlayingTask = self.service.fetchMovieNowPlayingList { result in
            switch result {
            case .success(let moviesPage):
                self.nowPlayingItems = moviesPage.movies
                self.nowPlayingState = .success
            case .failure:
                self.nowPlayingState = .error
            }
            self.nowPlayingTask = nil
        }
    }
    
    private func loadMovieTrending() {
        self.trendingState = .loading
        self.trendingTask = self.service.fetchMovieTrendingList { result in
            switch result {
            case .success(let moviesPage):
                self.trendingItems = moviesPage.movies
                self.trendingState = .success
            case .failure:
                self.trendingState = .error
            }
            self.trendingTask = nil
        }
    }
    
    private func loadMovieDiscover() {
        self.discoverState = .loading
        self.discoverTask = self.service.fetchMovieDiscoverList { result in
            switch result {
            case .success(let moviesPage):
                self.discoverItems = moviesPage.movies
                self.discoverState = .success
            case .failure:
                self.discoverState = .error
            }
            self.discoverTask = nil
        }
    }
    
    // MARK: - TV Show
    private func loadTVShowNowPlaying() {
        self.nowPlayingState = .loading
        self.nowPlayingTask = self.service.fetchTVShowNowPlayingList { result in
            switch result {
            case .success(let tvShowsPage):
                self.nowPlayingItems = tvShowsPage.tvShows
                self.nowPlayingState = .success
            case .failure:
                self.nowPlayingState = .error
            }
            self.nowPlayingTask = nil
        }
    }
    
    private func loadTVShowTrending() {
        self.trendingState = .loading
        self.trendingTask = self.service.fetchTVShowTrendingList { result in
            switch result {
            case .success(let tvShowsPage):
                self.trendingItems = tvShowsPage.tvShows
                self.trendingState = .success
            case .failure:
                self.trendingState = .error
            }
            self.trendingTask = nil
        }
    }
    
    private func loadTVShowDiscover() {
        self.discoverState = .loading
        self.discoverTask = self.service.fetchTVShowDiscoverList { result in
            switch result {
            case .success(let tvShowsPage):
                self.discoverItems = tvShowsPage.tvShows
                self.discoverState = .success
            case .failure:
                self.discoverState = .error
            }
            self.discoverTask = nil
        }
    }
}
