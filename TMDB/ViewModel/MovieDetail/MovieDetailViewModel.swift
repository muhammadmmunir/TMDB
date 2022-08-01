//
//  MovieDetailViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol MovieDetailViewModelInterface: ObservableObject {
    var movie: MovieBase { get set }
    var reviewsState: APIServiceState { get set }
    var reviews: [Review] { get set }
    var selectedType: Int { get set }
    var title: String { get }
    var posterURL: URL? { get }
    var backdropURL: URL? { get }
    var overviewLabel: String { get }
    var overview: String { get }
    var releaseDateLabel: String { get }
    var reviewLabel: String { get }
    var review: String { get }
    var reviewerAvatar: URL? { get }
    var reviewerName: String { get }
    var seeAllReviewsLabel: String { get }
    
    func loadReviews()
    func releaseDateFormatted() -> String
    func voteAverageFormatted() -> String
}

final class MovieDetailViewModel: MovieDetailViewModelInterface {
    @Published var movie: MovieBase
    @Published var reviewsState: APIServiceState = .initial
    @Published var reviews = [Review]()
    
    var selectedType: Int = 0
    
    var title: String {
        self.movie.getTitle()
    }
    var posterURL: URL? {
        self.movie.posterURL
    }
    var backdropURL: URL? {
        self.movie.backdropURL
    }
    var overviewLabel: String {
        self.wording.str(.generalOverview)
    }
    var overview: String {
        self.movie.overview ?? ""
    }
    var releaseDateLabel: String {
        self.wording.str(.generalReleaseDate)
    }
    var reviewLabel: String {
        self.wording.str(.generalReview)
    }
    var review: String {
        return self.reviews.first?.content ?? ""
    }
    var reviewerAvatar: URL? {
        self.reviews.first?.avatarURL
    }
    var reviewerName: String {
        self.reviews.first?.name ?? ""
    }
    var seeAllReviewsLabel: String {
        self.wording.str(.generalSeeAllReview)
    }
    
    private let wording: Wording
    private let dateFormatter: DateFormatter
    private var service: MovieDetailServiceInterface
    private var reviewsTask: APIServiceCancellableInterface? {
        willSet {
            self.reviewsTask?.cancel()
        }
    }
    
    init(
        selectedType: Int = 0,
        movie: MovieBase = .init(),
        wording: Wording = .init(),
        dateFormatter: DateFormatter = .init(),
        service: MovieDetailServiceInterface = MovieDetailService()
    ) {
        self.selectedType = selectedType
        self.movie = movie
        self.wording = wording
        self.dateFormatter = dateFormatter
        self.service = service
        self.loadReviews()
    }
    
    func loadReviews() {
        if self.selectedType == 0 {
            self.loadMovieReviews()
        } else {
            self.loadTVShowReviews()
        }
    }
    
    func releaseDateFormatted() -> String {
        guard let releaseDateRaw = self.movie.getReleaseDate()
        else { return "" }
        
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = self.dateFormatter.date(from: releaseDateRaw)
        else { return releaseDateRaw }
        
        self.dateFormatter.dateFormat = "dd MMM yyyy"
        let formatted = self.dateFormatter.string(from: date)
        
        return formatted
    }
    
    func voteAverageFormatted() -> String {
        var vote = self.movie.voteAverage ?? 0
        
        // rounding 2 digit
        let divisor = pow(10.0, Double(2))
        vote = (vote * divisor).rounded() / divisor
        
        return vote.isZero ? "NA" : "\(vote)"
    }
    
    private func loadMovieReviews() {
        self.reviewsState = .loading
        self.reviewsTask = self.service.fetchMovieReviewsList(
            movieId: self.movie.id
        ) { result in
            switch result {
            case .success(let reviewsPage):
                self.reviews = reviewsPage.reviews
                self.reviewsState = .success
            case .failure:
                self.reviewsState = .error
            }
            self.reviewsTask = nil
        }
    }
    
    private func loadTVShowReviews() {
        self.reviewsState = .loading
        self.reviewsTask = self.service.fetchTVShowReviewsList(
            tvShowId: self.movie.id
        ) { result in
            switch result {
            case .success(let reviewsPage):
                self.reviews = reviewsPage.reviews
                self.reviewsState = .success
            case .failure:
                self.reviewsState = .error
            }
            self.reviewsTask = nil
        }
    }
}
