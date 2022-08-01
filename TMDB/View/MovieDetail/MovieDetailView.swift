//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI
import UIKit

struct MovieDetailView<T>: View where T: MovieDetailViewModelInterface {
    @State private var likeImage: String = "hand.thumbsup"
    @State private var dislikeImage: String = "hand.thumbsdown"
    @State private var isLiked: Bool? {
        didSet {
            self.voted()
        }
    }
    @ObservedObject var viewModel: T
    
    private let backdropWidth: CGFloat = UIScreen.main.bounds.size.width
    private let backdropHeight: CGFloat = 250
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                self.poster
                self.vote
                self.detail
                if self.viewModel.reviewsState == .loading {
                    Shimmer()
                        .frame(height: 70)
                } else {
                    self.review
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.title)
        .toolbar {
            self.searchButton
        }
    }
    
    private var searchButton: some View {
        NavigationLink(destination: {
            SearchView(
                viewModel: SearchViewModel(selectedType: viewModel.selectedType)
            )
        }) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.tWhite)
        }
    }
    
    private var poster: some View {
        ZStack(alignment: .top) {
            WebImage(
                url: self.viewModel.backdropURL,
                config: {
                    AnyView(
                        AnyView($0.resizable())
                            .scaledToFill()
                            .frame(
                                width: self.backdropWidth,
                                height: self.backdropHeight)
                    )
                },
                placeholder: {
                    AnyView(
                        AnyView(self.posterPlaceholder)
                    )
                }
            )
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient:
                            Gradient(
                                colors: [.tBlack, .clear]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .frame(height: 50)
                .offset(x: 0, y: 0)
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient:
                            Gradient(
                                colors: [.clear, .tBlack]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .frame(height: 50)
                .offset(x: 0, y: 200)
        }
    }
    
    private var posterPlaceholder: some View {
        Text(self.viewModel.title)
            .font(.tTitle2).bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.tWhite)
            .frame(width: self.backdropWidth, height: self.backdropHeight)
    }
    
    private func likeButton() {
        if let isLiked = self.isLiked, isLiked {
            self.isLiked = nil
        } else {
            self.isLiked = true
        }
    }
    
    private func dislikeButton() {
        if let isLiked = self.isLiked, !isLiked {
            self.isLiked = nil
        } else {
            self.isLiked = false
        }
    }
    
    private func voted() {
        if let isLiked = self.isLiked {
            if isLiked {
                self.likeImage = "hand.thumbsup.fill"
                self.dislikeImage = "hand.thumbsdown"
            } else {
                self.likeImage = "hand.thumbsup"
                self.dislikeImage = "hand.thumbsdown.fill"
            }
        } else {
            self.likeImage = "hand.thumbsup"
            self.dislikeImage = "hand.thumbsdown"
        }
    }
    
    private var vote: some View {
        HStack(alignment: .center) {
            Text(self.viewModel.voteAverageFormatted())
                .font(.tTitle).bold()
                .foregroundColor(.tWhite)
            Spacer()
            HStack {
                Button(action: {
                    self.likeButton()
                }, label: {
                    Image(systemName: likeImage)
                        .foregroundColor(.tWhite)
                })
                Spacer()
                    .frame(width: 20)
                Button(action: {
                    self.dislikeButton()
                }, label: {
                    Image(systemName: dislikeImage)
                        .foregroundColor(.tWhite)
                })
            }
        }.padding(
            EdgeInsets(
                top: 16,
                leading: 16,
                bottom: 16,
                trailing: 16)
        )
    }
    
    private var detail: some View {
        VStack(alignment: .leading, spacing: 32) {
            self.detailSection(
                label: self.viewModel.overviewLabel,
                value: self.viewModel.overview)
            self.detailSection(
                label: self.viewModel.releaseDateLabel,
                value: self.viewModel.releaseDateFormatted())
        }
        .padding(
            EdgeInsets(
                top: 16,
                leading: 16,
                bottom: 16,
                trailing: 16)
        )
    }
    
    private func detailSection(
        label: String,
        value: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(label)
                .font(.tTitle2).bold()
                .foregroundColor(.tWhite)
                .multilineTextAlignment(.leading)
            Text(value)
                .font(.tCaption)
                .foregroundColor(.tWhite)
                .multilineTextAlignment(.leading)
        }
    }
    
    private var review: some View {
        VStack(spacing: 16) {
            HStack {
                Text(self.viewModel.reviewLabel)
                    .font(.tTitle2).bold()
                    .foregroundColor(.tWhite)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            if self.viewModel.review.isEmpty {
                HStack {
                    Text("NA")
                        .font(.tTitle3)
                        .foregroundColor(.tWhite)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            } else {
                BubbleReview(
                    reviewerAvatar: self.viewModel.reviewerAvatar,
                    reviewerName: self.viewModel.reviewerName,
                    review: self.viewModel.review)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: {
                        AllReviewView(
                            viewModel: AllReviewViewModel(reviews: self.viewModel.reviews)
                        )
                    }, label: {
                        Text(self.viewModel.seeAllReviewsLabel)
                            .font(.tHeadline).bold()
                            .foregroundColor(.tWhite)
                            .multilineTextAlignment(.leading)
                    })
                }
            }
        }.padding(
            EdgeInsets(
                top: 16,
                leading: 24,
                bottom: 16,
                trailing: 24)
        )
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                MovieDetailView(
                    viewModel: MovieDetailViewModel(
                        movie: Movie(id: 1, posterPath: "", backdropPath: "/393mh1AJ0GYWVD7Hsq5KkFaTAoT.jpg", overview: "overview", voteAverage: 7, title: "title", releaseDate: "")
                    )
                )
            }
            .preferredColorScheme(.dark)
        }
    }
}
