//
//  HomeViewModelTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

import XCTest
import Combine
@testable import TMDB

final class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var wording: Wording!
    private var service: MockHomeService!
    private var cancellables = Set<AnyCancellable>()
    private let defaultMovie = Movie(
        id: 1,
        posterPath: nil,
        backdropPath: nil,
        overview: nil,
        voteAverage: nil,
        title: "",
        releaseDate: nil)
    private let defaultTVShow = TVShow(
        id: 1,
        posterPath: nil,
        backdropPath: nil,
        overview: nil,
        voteAverage: nil,
        name: "",
        firstAirDate: nil)
    
    override func setUp() {
        super.setUp()
        self.wording = Wording()
        self.service = MockHomeService()
        self.sut = HomeViewModel(
            selectedType: 0, wording: self.wording, service: self.service)
    }
    
    override func tearDown() {
        self.sut = nil
        self.wording = nil
        self.service = nil
        super.tearDown()
    }
    
    func test_whenWordingObjectCorrect_shouldReturnCorrectTitle() {
        XCTAssertEqual(self.sut.trendingTitle, self.wording.str(.generalTrending))
        XCTAssertEqual(self.sut.discoverTitle, self.wording.str(.generalDiscover))
    }
    
    func test_whenMovieSelectedAndReturnSuccess_shouldReturnSuccessWithAllMovieItems() {
        self.service.nowPlayingMoviesPage = MoviesPage(
            page: 1, totalPages: 1, movies: [self.defaultMovie])
        self.service.fetchMovieNowPlayingSuccess = true
        self.service.trendingMoviesPage = MoviesPage(
            page: 1, totalPages: 1, movies: [self.defaultMovie, self.defaultMovie])
        self.service.fetchMovieTrendingSuccess = true
        self.service.discoverMoviesPage = MoviesPage(
            page: 1, totalPages: 1, movies: [
                self.defaultMovie, self.defaultMovie, self.defaultMovie])
        self.service.fetchMovieDiscoverSuccess = true
        let expectation = self.expectation(description: "Should return all movie items")
        
        self.sut.$selectedType
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.selectedType = 0
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.nowPlayingState, .success)
            XCTAssertEqual(self.sut.trendingState, .success)
            XCTAssertEqual(self.sut.discoverState, .success)
            XCTAssertEqual(self.sut.nowPlayingItems, [self.defaultMovie])
            XCTAssertEqual(self.sut.trendingItems, [self.defaultMovie, self.defaultMovie])
            XCTAssertEqual(self.sut.discoverItems,
                           [self.defaultMovie, self.defaultMovie, self.defaultMovie])
            XCTAssertTrue(self.sut.nowPlayingItems.first is Movie)
            XCTAssertTrue(self.sut.trendingItems.first is Movie)
            XCTAssertTrue(self.sut.discoverItems.first is Movie)
        }
    }
    
    func test_whenMovieSelectedAndReturnError_shouldReturnErrorState() {
        self.service.fetchMovieNowPlayingSuccess = false
        self.service.fetchMovieTrendingSuccess = false
        self.service.fetchMovieDiscoverSuccess = false
        let expectation = self.expectation(description: "Should return error state")
        
        self.sut.$selectedType
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.selectedType = 0
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.nowPlayingState, .error)
            XCTAssertEqual(self.sut.trendingState, .error)
            XCTAssertEqual(self.sut.discoverState, .error)
            XCTAssertEqual(self.sut.nowPlayingItems, [])
            XCTAssertEqual(self.sut.trendingItems, [])
            XCTAssertEqual(self.sut.discoverItems, [])
        }
    }
    
    func test_whenTVShowSelectedAndReturnSuccess_shouldReturnSuccessWithAllTVShowItems() {
        self.service.nowPlayingTvShowsPage = TVShowsPage(
            page: 1, totalPages: 1, tvShows: [self.defaultTVShow])
        self.service.fetchTVShowNowPlayingSuccess = true
        self.service.trendingTvShowsPage = TVShowsPage(
            page: 1, totalPages: 1, tvShows: [self.defaultTVShow, self.defaultTVShow])
        self.service.fetchTVShowTrendingSuccess = true
        self.service.discoverTvShowsPage = TVShowsPage(
            page: 1, totalPages: 1, tvShows: [
                self.defaultTVShow, self.defaultTVShow, self.defaultTVShow])
        self.service.fetchTVShowDiscoverSuccess = true
        let expectation = self.expectation(description: "Should return all tv show items")
        
        self.sut.$selectedType
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.selectedType = 1
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.nowPlayingState, .success)
            XCTAssertEqual(self.sut.trendingState, .success)
            XCTAssertEqual(self.sut.discoverState, .success)
            XCTAssertEqual(self.sut.nowPlayingItems, [self.defaultTVShow])
            XCTAssertEqual(self.sut.trendingItems, [self.defaultTVShow, self.defaultTVShow])
            XCTAssertEqual(self.sut.discoverItems,
                           [self.defaultTVShow, self.defaultTVShow, self.defaultTVShow])
            XCTAssertTrue(self.sut.nowPlayingItems.first is TVShow)
            XCTAssertTrue(self.sut.trendingItems.first is TVShow)
            XCTAssertTrue(self.sut.discoverItems.first is TVShow)
        }
    }
    
    func test_whenTVShowSelectedAndReturnError_shouldReturnErrorState() {
        self.service.fetchTVShowNowPlayingSuccess = false
        self.service.fetchTVShowTrendingSuccess = false
        self.service.fetchTVShowDiscoverSuccess = false
        let expectation = self.expectation(description: "Should return error state")
        
        self.sut.$selectedType
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.selectedType = 1
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.nowPlayingState, .error)
            XCTAssertEqual(self.sut.trendingState, .error)
            XCTAssertEqual(self.sut.discoverState, .error)
            XCTAssertEqual(self.sut.nowPlayingItems, [])
            XCTAssertEqual(self.sut.trendingItems, [])
            XCTAssertEqual(self.sut.discoverItems, [])
        }
    }
}
