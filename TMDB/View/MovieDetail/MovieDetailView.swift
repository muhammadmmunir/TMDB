//
//  MovieDetailView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @State private var likeImage: String = "hand.thumbsup"
    @State private var dislikeImage: String = "hand.thumbsdown"
    @State var isLiked: Bool? {
        didSet {
            self.voted()
        }
    }
    private let wording: Wording
    
    init(wording: Wording = .init()) {
        self.wording = wording
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                self.poster
                self.vote
                self.detail
                self.review
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("One Piece Film: Red")
        .toolbar {
            self.searchButton
        }
    }
    
    private var searchButton: some View {
        NavigationLink(destination: {
            SearchView()
        }) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.tWhite)
        }
    }
    
    private var poster: some View {
        ZStack(alignment: .top) {
            WebImage(url: URL(string: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"))
                .resizable()
                .placeholder {
                    self.posterPlaceholder
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.25))
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .clipShape(Rectangle())
            
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
                .offset(x: 0, y: 250)
            
        }
    }
    
    private var posterPlaceholder: some View {
        Text("placeholder")
            .font(.tTitle2).bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.tWhite)
            .frame(maxWidth: .infinity)
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
            Text("1.200 votes")
                .font(.tHeadline)
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
                label: self.wording.str(.generalOverview),
                value: "Detail overview Detail overview Detail overview Detail overview Detail overview Detail overview Detail overview Detail overview Detail overview")
            self.detailSection(
                label: self.wording.str(.generalReleaseDate),
                value: "10 Aug 2022")
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
                Text(self.wording.str(.generalReview))
                    .font(.tTitle2).bold()
                    .foregroundColor(.tWhite)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(.tWhite)
                    .cornerRadius(8)

                VStack(alignment: .leading) {
                    HStack(spacing: 8) {
                        WebImage(url: URL(string: "https://wallpaperaccess.com/full/5960274.jpg"))
                            .resizable()
                            .placeholder {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .foregroundColor(.tDarkGray)
                                    .frame(
                                        width: 25,
                                        height: 25
                                    )
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.25))
                            .scaledToFill()
                            .frame(
                                width: 25,
                                height: 25,
                                alignment: .center
                            )
                            .clipShape(Circle())
                        
                        Text("Batman")
                            .font(.tSubheadline)
                            .foregroundColor(.tBlack)
                            .lineLimit(1)
                    }
                    
                    Text("\"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\"")
                        .font(.tCaption)
                        .foregroundColor(.tBlack)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                }.padding(
                    EdgeInsets(
                        top: 8,
                        leading: 8,
                        bottom: 8,
                        trailing: 8)
                )
            }
            
            HStack {
                Spacer()
                NavigationLink(destination: {
                    AllReviewView()
                }, label: {
                    Text(self.wording.str(.generalSeeAllReview))
                        .font(.tHeadline).bold()
                        .foregroundColor(.tWhite)
                        .multilineTextAlignment(.leading)
                })
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
                MovieDetailView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
