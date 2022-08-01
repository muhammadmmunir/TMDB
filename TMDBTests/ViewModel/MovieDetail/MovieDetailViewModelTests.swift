//
//  MovieDetailViewModelTests.swift
//  TMDBTests
//
//  Created by Muhammad M Munir on 01/08/22.
//

import XCTest
@testable import TMDB

final class MovieDetailViewModelTests: XCTestCase {
    
    private var sut: MovieDetailViewModel!
    private var wording: Wording!
    private var service: MockMovieDetailService!
    private let defaultMovie = Movie(
        id: 1,
        posterPath: "/posterPath",
        backdropPath: "/backdropPath",
        overview: "overview",
        voteAverage: 5.5,
        title: "title",
        releaseDate: "2022-08-24")
    private let defaultTVShow = TVShow(
        id: 1,
        posterPath: "/posterPath",
        backdropPath: "/backdropPath",
        overview: "overview",
        voteAverage: 5.5,
        name: "name",
        firstAirDate: "2022-08-22")
    private let defaultReview = Review(
        id: "21dasd",
        name: "lightning",
        avatarPath: "/avatarPath",
        content: "review content")
    
    override func setUp() {
        super.setUp()
        self.wording = Wording()
        self.service = MockMovieDetailService()
        self.sut = MovieDetailViewModel(
            selectedType: 0,
            movie: self.defaultMovie,
            wording: self.wording,
            dateFormatter: .init(),
            service: self.service)
    }
    
    override func tearDown() {
        self.sut = nil
        self.wording = nil
        self.service = nil
        super.tearDown()
    }
    
    func test_whenPassingCorrectMovieObject_shouldReturnCorrectProperties() {
        self.sut.movie = self.defaultMovie
        self.sut.reviews = [defaultReview]
        
        XCTAssertEqual(self.sut.title, self.defaultMovie.title)
        XCTAssertEqual(self.sut.posterURL, self.defaultMovie.posterURL)
        XCTAssertEqual(self.sut.backdropURL, self.defaultMovie.backdropURL)
        XCTAssertEqual(self.sut.overviewLabel, self.wording.str(.generalOverview))
        XCTAssertEqual(self.sut.overview, self.defaultMovie.overview)
        XCTAssertEqual(self.sut.releaseDateLabel, self.wording.str(.generalReleaseDate))
        XCTAssertEqual(self.sut.releaseDateFormatted(), "24 Aug 2022")
        XCTAssertEqual(self.sut.reviewLabel, self.wording.str(.generalReview))
        XCTAssertEqual(self.sut.review, self.defaultReview.content)
        XCTAssertEqual(self.sut.reviewerAvatar, self.defaultReview.avatarURL)
        XCTAssertEqual(self.sut.reviewerName, self.defaultReview.name)
        XCTAssertEqual(self.sut.seeAllReviewsLabel, self.wording.str(.generalSeeAllReview))
    }
    
    func test_whenPassingCorrectTVShowObject_shouldReturnCorrectProperties() {
        self.sut.movie = self.defaultTVShow
        self.sut.reviews = [defaultReview]
        
        XCTAssertEqual(self.sut.title, self.defaultTVShow.name)
        XCTAssertEqual(self.sut.posterURL, self.defaultTVShow.posterURL)
        XCTAssertEqual(self.sut.backdropURL, self.defaultTVShow.backdropURL)
        XCTAssertEqual(self.sut.overviewLabel, self.wording.str(.generalOverview))
        XCTAssertEqual(self.sut.overview, self.defaultTVShow.overview)
        XCTAssertEqual(self.sut.releaseDateLabel, self.wording.str(.generalReleaseDate))
        XCTAssertEqual(self.sut.releaseDateFormatted(), "22 Aug 2022")
        XCTAssertEqual(self.sut.reviewLabel, self.wording.str(.generalReview))
        XCTAssertEqual(self.sut.review, self.defaultReview.content)
        XCTAssertEqual(self.sut.reviewerAvatar, self.defaultReview.avatarURL)
        XCTAssertEqual(self.sut.reviewerName, self.defaultReview.name)
        XCTAssertEqual(self.sut.seeAllReviewsLabel, self.wording.str(.generalSeeAllReview))
    }
    
    func test_whenReleaseDateValidFormat_shouldReturnReleaseDateFormatted() {
        self.sut.movie = self.defaultMovie
        
        XCTAssertEqual(self.sut.releaseDateFormatted(), "24 Aug 2022")
    }
    
    func test_whenReleaseDateInvalidFormat_shouldReturnReleaseDateUnformatted() {
        self.sut.movie = Movie(
            id: 1,
            posterPath: nil,
            backdropPath: nil,
            overview: nil,
            voteAverage: nil,
            title: "",
            releaseDate: "22-08-2022")
        
        XCTAssertEqual(self.sut.releaseDateFormatted(), "22-08-2022")
    }
    
    func test_whenReleaseDateNil_shouldReturnEmptyString() {
        self.sut.movie = Movie(
            id: 1,
            posterPath: nil,
            backdropPath: nil,
            overview: nil,
            voteAverage: nil,
            title: "",
            releaseDate: nil)
        
        XCTAssertEqual(self.sut.releaseDateFormatted(), "")
    }
    
    func test_whenVoteAverageValid_shouldReturnVoteAverageFormatted() {
        self.sut.movie = Movie(
            id: 1,
            posterPath: nil,
            backdropPath: nil,
            overview: nil,
            voteAverage: 8.12531,
            title: "",
            releaseDate: nil)
        
        XCTAssertEqual(self.sut.voteAverageFormatted(), "8.13")
    }
    
    func test_whenVoteAverageValid2_shouldReturnVoteAverageFormatted() {
        self.sut.movie = Movie(
            id: 1,
            posterPath: nil,
            backdropPath: nil,
            overview: nil,
            voteAverage: 7.42,
            title: "",
            releaseDate: nil)
        
        XCTAssertEqual(self.sut.voteAverageFormatted(), "7.42")
    }
    
    func test_whenVoteAverageNil_shouldReturnNA() {
        self.sut.movie = Movie(
            id: 1,
            posterPath: nil,
            backdropPath: nil,
            overview: nil,
            voteAverage: nil,
            title: "",
            releaseDate: nil)
        
        XCTAssertEqual(self.sut.voteAverageFormatted(), "NA")
    }
    
    func test_whenMovieCaseServiceReturnFailure_shouldReturnErrorState() {
        self.sut.selectedType = 0
        self.service.fetchMovieReviewStatus = false
        
        self.sut.loadReviews()
        
        XCTAssertEqual(self.sut.reviews, [])
        XCTAssertEqual(self.sut.reviewsState, .error)
    }
    
    func test_whenMovieCaseServiceReturnSuccess_shouldReturnSuccessState() {
        self.sut.selectedType = 0
        self.service.reviewPage = ReviewsPage(
            page: 1, totalPages: 1, reviews: [self.defaultReview])
        self.service.fetchMovieReviewStatus = true
        
        self.sut.loadReviews()
        
        XCTAssertEqual(self.sut.reviews, [self.defaultReview])
        XCTAssertEqual(self.sut.reviewsState, .success)
    }
    
    func test_whenTVShowCaseServiceReturnFailure_shouldReturnErrorState() {
        self.sut.selectedType = 1
        self.service.fetchTVShowReviewStatus = false
        
        self.sut.loadReviews()
        
        XCTAssertEqual(self.sut.reviews, [])
        XCTAssertEqual(self.sut.reviewsState, .error)
    }
    
    func test_whenTVShowCaseServiceReturnSuccess_shouldReturnSuccessState() {
        self.sut.selectedType = 1
        self.service.reviewPage = ReviewsPage(
            page: 1, totalPages: 1, reviews: [self.defaultReview])
        self.service.fetchTVShowReviewStatus = true
        
        self.sut.loadReviews()
        
        XCTAssertEqual(self.sut.reviews, [self.defaultReview])
        XCTAssertEqual(self.sut.reviewsState, .success)
    }
}
