//
//  MovieBaseTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

import XCTest
@testable import TMDB

class MovieBaseTests: XCTestCase {

    private var sut: MovieBase!
    private let defaultMovieBase = MovieBase(
        id: 1,
        posterPath: "/poster/path",
        backdropPath: "/backdrop/path",
        overview: "overview",
        voteAverage: 8.9)
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }

    func test_initDefault() {
        self.sut = MovieBase()
        
        XCTAssertEqual(self.sut.id, 0)
        XCTAssertEqual(self.sut.posterPath, nil)
        XCTAssertEqual(self.sut.backdropPath, nil)
        XCTAssertEqual(self.sut.overview, nil)
        XCTAssertEqual(self.sut.voteAverage, nil)
    }
    
    func test_initWithParam() {
        self.sut = self.defaultMovieBase
        
        XCTAssertEqual(self.sut.id, 1)
        XCTAssertEqual(self.sut.posterPath, "/poster/path")
        XCTAssertEqual(self.sut.backdropPath, "/backdrop/path")
        XCTAssertEqual(self.sut.overview, "overview")
        XCTAssertEqual(self.sut.voteAverage, 8.9)
    }
    
    func test_getPosterURL() {
        let expected = URL(string: APIConfig.baseImageURL + "w500" + "/poster/path")
        
        self.sut = self.defaultMovieBase
        
        XCTAssertEqual(self.sut.posterURL, expected)
    }
    
    func test_getBackdropURL() {
        let expected = URL(string: APIConfig.baseImageURL + "w780" + "/backdrop/path")
        
        self.sut = self.defaultMovieBase
        
        XCTAssertEqual(self.sut.backdropURL, expected)
    }
    
    func test_getTitle() {
        self.sut = MovieBase()
        XCTAssertEqual(self.sut.getTitle(), "")
    }
    
    func test_getReleaseDate() {
        self.sut = MovieBase()
        XCTAssertEqual(self.sut.getReleaseDate(), nil)
    }
    
    func test_equatable() {
        let lhs = self.defaultMovieBase
        let rhs = self.defaultMovieBase
        
        XCTAssertTrue(lhs == rhs)
    }
    
    func test_nonEquatable() {
        let lhs = self.defaultMovieBase
        let rhs = MovieBase()
        
        XCTAssertFalse(lhs == rhs)
    }
}
