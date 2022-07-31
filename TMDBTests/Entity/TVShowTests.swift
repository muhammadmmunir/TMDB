//
//  TVShowTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

import XCTest
@testable import TMDB

class TVShowTests: XCTestCase {

    private var sut: TVShow!
    private let defaultTVShow = TVShow(
        id: 1,
        posterPath: "/poster/path",
        backdropPath: "/backdrop/path",
        overview: "overview",
        voteAverage: 9.1,
        name: "One Piece",
        firstAirDate: "2022-08-24")
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    func test_initWithParam() {
        self.sut = self.defaultTVShow
        
        XCTAssertEqual(self.sut.id, 1)
        XCTAssertEqual(self.sut.posterPath, "/poster/path")
        XCTAssertEqual(self.sut.backdropPath, "/backdrop/path")
        XCTAssertEqual(self.sut.overview, "overview")
        XCTAssertEqual(self.sut.voteAverage, 9.1)
        XCTAssertEqual(self.sut.name, "One Piece")
        XCTAssertEqual(self.sut.firstAirDate, "2022-08-24")
    }
    
    func test_getTitle() {
        self.sut = self.defaultTVShow
        XCTAssertEqual(self.sut.getTitle(), "One Piece")
    }
    
    func test_getReleaseDate() {
        self.sut = self.defaultTVShow
        XCTAssertEqual(self.sut.getReleaseDate(), "2022-08-24")
    }
}
