//
//  APIPathTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 31/07/22.
//

import XCTest
@testable import TMDB

class APIPathTests: XCTestCase {
    
    func test_moviePath() {
        XCTAssertEqual(APIPath.Movie.nowPlaying.rawValue, "movie/now_playing")
        XCTAssertEqual(APIPath.Movie.trending.rawValue, "trending/movie/week")
        XCTAssertEqual(APIPath.Movie.discover.rawValue, "discover/movie")
        XCTAssertEqual(APIPath.Movie.reviews.rawValue, "movie/{movie_id}/reviews")
        XCTAssertEqual(APIPath.Movie.search.rawValue, "search/movie")
    }
    
    func test_tvShowPath() {
        XCTAssertEqual(APIPath.TVShow.nowPlaying.rawValue, "tv/on_the_air")
        XCTAssertEqual(APIPath.TVShow.trending.rawValue, "trending/tv/week")
        XCTAssertEqual(APIPath.TVShow.discover.rawValue, "discover/tv")
        XCTAssertEqual(APIPath.TVShow.reviews.rawValue, "tv/{tv_id}/reviews")
        XCTAssertEqual(APIPath.TVShow.search.rawValue, "search/tv")
    }
}
