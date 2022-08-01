//
//  SearchViewModelTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

import XCTest
import Combine
@testable import TMDB

final class SearchViewModelTests: XCTestCase {
    
    private var sut: SearchViewModel!
    private var wording: Wording!
    private var service: MockSearchService!
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
        self.service = MockSearchService()
        self.sut = SearchViewModel(
            wording: self.wording,
            service: self.service,
            selectedType: 0
        )
    }
    
    override func tearDown() {
        self.sut = nil
        self.wording = nil
        self.service = nil
        super.tearDown()
    }
    
    func test_whenSelectedTypeEqual0_shouldGetSearchPlaceholderMovie() {
        self.sut.selectedType = 0
        let result = self.sut.searchPlaceholder
        
        XCTAssertEqual(result, self.wording.str(.generalSearchMovie))
    }
    
    func test_whenSelectedTypeEqual1_shouldGetSearchPlaceholderTVShow() {
        self.sut.selectedType = 1
        let result = self.sut.searchPlaceholder
        
        XCTAssertEqual(result, self.wording.str(.generalSearchTVShow))
    }
    
    func test_whenMovieCaseSuccess_shouldReturnCorrectMovieItems() {
        self.sut.selectedType = 0
        self.service.fetchMovieStatus = true
        self.service.moviesPage = MoviesPage(
            page: 1,
            totalPages: 1,
            movies: [
                self.defaultMovie,
                self.defaultMovie,
                self.defaultMovie,
                self.defaultMovie,
                self.defaultMovie
            ]
        )
        let expectation = self.expectation(description: "Sould return correct movie items")
        let expectedItems = [
            [self.defaultMovie, self.defaultMovie, self.defaultMovie],
            [self.defaultMovie, self.defaultMovie]
        ]
        
        self.sut.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.searchText = "movie"
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(self.sut.items.first!.first is Movie)
            XCTAssertEqual(self.sut.items, expectedItems)
        }
    }
    
    func test_whenTVShowCaseSuccess_shouldReturnCorrectTVShowItems() {
        self.sut.selectedType = 1
        self.service.fetchTVShowStatus = true
        self.service.tvShowsPage = TVShowsPage(
            page: 1,
            totalPages: 1,
            tvShows: [
                self.defaultTVShow,
                self.defaultTVShow,
                self.defaultTVShow,
                self.defaultTVShow,
                self.defaultTVShow
            ]
        )
        let expectation = self.expectation(description: "Sould return correct tv show items")
        let expectedItems = [
            [self.defaultTVShow, self.defaultTVShow, self.defaultTVShow],
            [self.defaultTVShow, self.defaultTVShow]
        ]
        
        self.sut.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.searchText = "tv show"
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertTrue(self.sut.items.first!.first is TVShow)
            XCTAssertEqual(self.sut.items, expectedItems)
        }
    }
    
    func test_whenMovieCaseServiceReturnFailure_shouldReturnErrorState() {
        self.sut.selectedType = 0
        self.service.fetchMovieStatus = false
        let expectation = self.expectation(description: "Sould return error")
        
        self.sut.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.searchText = "error"
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.items, [])
            XCTAssertEqual(self.sut.state, .error)
        }
    }
    
    func test_whenMovieCaseServiceReturnSuccess_shouldReturnSuccessState() {
        self.sut.selectedType = 0
        self.service.fetchMovieStatus = true
        self.service.moviesPage = MoviesPage(page: 1, totalPages: 1, movies: [])
        let expectation = self.expectation(description: "Sould return success")
        
        self.sut.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.searchText = "success"
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.items, [])
            XCTAssertEqual(self.sut.state, .success)
        }
    }
    
    func test_whenTVShowCaseServiceReturnFailure_shouldReturnErrorState() {
        self.sut.selectedType = 1
        self.service.fetchTVShowStatus = false
        let expectation = self.expectation(description: "Sould return error")
        
        self.sut.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.searchText = "error"
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.items, [])
            XCTAssertEqual(self.sut.state, .error)
        }
    }
    
    func test_whenTVShowCaseServiceReturnSuccess_shouldReturnSuccessState() {
        self.sut.selectedType = 0
        self.service.fetchTVShowStatus = true
        self.service.tvShowsPage = TVShowsPage(page: 1, totalPages: 1, tvShows: [])
        let expectation = self.expectation(description: "Sould return success")
        
        self.sut.$searchText
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &self.cancellables)
        self.sut.searchText = "success"
        
        self.waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.sut.items, [])
            XCTAssertEqual(self.sut.state, .success)
        }
    }
}
