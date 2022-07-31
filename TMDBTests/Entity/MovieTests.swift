//
//  MovieTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

import XCTest
@testable import TMDB

class MovieTests: XCTestCase {

    private var sut: Movie!
    private let defaultMovie = Movie(
        id: 1,
        posterPath: "/poster/path",
        backdropPath: "/backdrop/path",
        overview: "overview",
        voteAverage: 9.1,
        title: "One Piece",
        releaseDate: "2022-08-24")
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_initWithParam() {
        self.sut = self.defaultMovie
        
        XCTAssertEqual(self.sut.id, 1)
        XCTAssertEqual(self.sut.posterPath, "/poster/path")
        XCTAssertEqual(self.sut.backdropPath, "/backdrop/path")
        XCTAssertEqual(self.sut.overview, "overview")
        XCTAssertEqual(self.sut.voteAverage, 9.1)
        XCTAssertEqual(self.sut.title, "One Piece")
        XCTAssertEqual(self.sut.releaseDate, "2022-08-24")
    }
    
    func test_getTitle() {
        self.sut = self.defaultMovie
        XCTAssertEqual(self.sut.getTitle(), "One Piece")
    }
    
    func test_getReleaseDate() {
        self.sut = self.defaultMovie
        XCTAssertEqual(self.sut.getReleaseDate(), "2022-08-24")
    }
}
