//
//  WordingTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 30/07/22.
//

import XCTest
@testable import TMDB

class WordingTests: XCTestCase {

    private var sut: Wording!
    private let id = [
        "general.tmdb": "TMDB",
        "general.guest": "Tamu",
        "general.hello": "Halo",
        "general.welcome": "Selamat Datang",
        "general.search": "Cari",
        "general.search.movie": "Cari Film...",
        "general.search.tvshow": "Cari Acara TV...",
        "general.popular": "Populer",
        "general.discover": "Discover",
        "general.trending": "Trending",
        "general.movies": "Film",
        "general.tvshows": "Acara TV",
        "general.home": "Beranda",
        "general.profile": "Profil",
        "general.typing": "Typing...",
        "general.overview": "Ikhtisar",
        "general.releasedate": "Tanggal Rilis",
        "general.review": "Ulasan",
        "general.seeallreview": "lihat semua ulasan",
        "general.allreview": "Semua Ulasan"
    ]
    private let en = [
        "general.tmdb": "TMDB",
        "general.guest": "Guest",
        "general.hello": "Hello",
        "general.welcome": "Welcome",
        "general.search": "Search",
        "general.search.movie": "Search Movie...",
        "general.search.tvshow": "Search TV Show...",
        "general.popular": "Popular",
        "general.discover": "Discover",
        "general.trending": "Trending",
        "general.movies": "Movies",
        "general.tvshows": "TV Shows",
        "general.home": "Home",
        "general.profile": "Profile",
        "general.typing": "Typing...",
        "general.overview": "Overview",
        "general.releasedate": "Release Date",
        "general.review": "Review",
        "general.seeallreview": "see all review",
        "general.allreview": "All Reviews"
    ]
    
    override func setUp() {
        super.setUp()
        self.sut = Wording(
            bundle: Bundle.main,
            local: Locale.current)
    }

    override func tearDown() {
        self.sut = nil
        super.tearDown()
    }
    
    /// Change App Language: Scheme -> Test -> Option -> App Language [English | Indonesian]
    private func getExpected(of key: WordingKey) -> String {
        let appLanguage = UserDefaults.standard
            .stringArray(forKey: "AppleLanguages")?.first ?? ""
        guard !appLanguage.isEmpty else { return "" }
        
        let wordings: [String: String] = {
            if appLanguage == "id" {
                return self.id
            } else if appLanguage == "en" {
                return self.en
            } else {
                return [:]
            }
        }()
        
        guard !wordings.isEmpty else { return "" }
        
        return wordings[key.rawValue] ?? ""
    }
    
    func test_wording() {
        let tmdb = self.sut.str(.generalTmdb)
        let guest = self.sut.str(.generalGuest)
        let hello = self.sut.str(.generalHello)
        let welcome = self.sut.str(.generalWelcome)
        let search = self.sut.str(.generalSearch)
        let searchmovie = self.sut.str(.generalSearchMovie)
        let searchtvshow = self.sut.str(.generalSearchTVShow)
        let popular = self.sut.str(.generalPopular)
        let discover = self.sut.str(.generalDiscover)
        let trending = self.sut.str(.generalTrending)
        let movies = self.sut.str(.generalMovies)
        let tvshows = self.sut.str(.generalTVShows)
        let home = self.sut.str(.generalHome)
        let profile = self.sut.str(.generalProfile)
        let typing = self.sut.str(.generalTyping)
        let overview = self.sut.str(.generalOverview)
        let releaseDate = self.sut.str(.generalReleaseDate)
        let review = self.sut.str(.generalReview)
        let seeallreview = self.sut.str(.generalSeeAllReview)
        let allreview = self.sut.str(.generalAllReview)
        
        XCTAssertEqual(tmdb, self.getExpected(of: .generalTmdb))
        XCTAssertEqual(guest, self.getExpected(of: .generalGuest))
        XCTAssertEqual(hello, self.getExpected(of: .generalHello))
        XCTAssertEqual(welcome, self.getExpected(of: .generalWelcome))
        XCTAssertEqual(search, self.getExpected(of: .generalSearch))
        XCTAssertEqual(searchmovie, self.getExpected(of: .generalSearchMovie))
        XCTAssertEqual(searchtvshow, self.getExpected(of: .generalSearchTVShow))
        XCTAssertEqual(popular, self.getExpected(of: .generalPopular))
        XCTAssertEqual(discover, self.getExpected(of: .generalDiscover))
        XCTAssertEqual(trending, self.getExpected(of: .generalTrending))
        XCTAssertEqual(movies, self.getExpected(of: .generalMovies))
        XCTAssertEqual(tvshows, self.getExpected(of: .generalTVShows))
        XCTAssertEqual(home, self.getExpected(of: .generalHome))
        XCTAssertEqual(profile, self.getExpected(of: .generalProfile))
        XCTAssertEqual(typing, self.getExpected(of: .generalTyping))
        XCTAssertEqual(overview, self.getExpected(of: .generalOverview))
        XCTAssertEqual(releaseDate, self.getExpected(of: .generalReleaseDate))
        XCTAssertEqual(review, self.getExpected(of: .generalReview))
        XCTAssertEqual(seeallreview, self.getExpected(of: .generalSeeAllReview))
        XCTAssertEqual(allreview, self.getExpected(of: .generalAllReview))
    }
}
