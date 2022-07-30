//
//  SearchView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    private let cellWidth: CGFloat = 100
    private let cellHeight: CGFloat = 180
    
    private let wording: Wording
    @ObservedObject var viewModel: SearchViewModel
    
    init(
        wording: Wording = .init(),
        viewModel: SearchViewModel = .init()
    ) {
        self.wording = wording
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center, spacing: 16) {
                SearchBar(text: self.$viewModel.searchText)
                    .frame(height: 60)
                
                if self.viewModel.state == .loading {
                    self.loadingView
                } else {
                    if !self.viewModel.items.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(0..<self.viewModel.items.count, id: \.self) { index in
                                    HStack(alignment: .center, spacing: 10) {
                                        ForEach(self.viewModel.items[index], id: \.id) { movie in
                                            self.cellLink(using: movie)
                                        }
                                    }.frame(maxWidth: .infinity)
                                }
                            }
                        }.gesture(
                            DragGesture()
                                .onChanged { _ in
                                    UIApplication.shared.endEditing(true)
                                }
                        )
                    } else {
                        EmptyView()
                    }
                }
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            self.wording.str(.generalSearch))
    }
    
    private var loadingView: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(0..<5, id: \.self) { _  in
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(0..<3, id: \.self) { _  in
                            self.shimmerCell
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
        }.gesture(
            DragGesture()
                .onChanged { _ in
                    UIApplication.shared.endEditing(true)
                }
        )
    }
    
    private var shimmerCell: some View {
        VStack(alignment: .leading) {
            Shimmer()
                .frame(
                    width: self.cellWidth,
                    height: self.cellHeight)
                .cornerRadius(8.0)
        }
    }
    
    private func cellLink(
        using movie: Movie
    ) -> some View {
        return NavigationLink {
            MovieDetailView()
        } label: {
            self.cell(using: movie)
        }

    }
    
    private func cell(using movie: Movie) -> some View {
        return VStack(alignment: .leading) {
            Group {
                if movie.posterUrl != nil {
                    self.poster(
                        title: movie.title,
                        url: movie.posterUrl)
                } else {
                    self.posterPlaceholder(
                        using: movie.title)
                }
            }
            .frame(
                width: self.cellWidth,
                height: 160)
            .background(Color.tDarkGray)
            .cornerRadius(8)
            
            Text(movie.title)
                .font(.tCaption2.bold())
                .lineLimit(1)
                .foregroundColor(.tWhite)
                .frame(width: self.cellWidth)
        }
    }
    
    private func poster(
        title: String,
        url: URL?
    ) -> some View {
        WebImage(url: url)
            .resizable()
            .placeholder {
                self.posterPlaceholder(
                    using: title)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.25))
            .scaledToFill()
    }
    
    private func posterPlaceholder(
        using title: String
    ) -> some View {
        Text(title)
            .font(.tTitle3).bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.tWhite)
            .frame(width: self.cellWidth)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
