//
//  SearchView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct SearchView<T>: View where T: SearchViewModelInterface {
    private let cellWidth: CGFloat = 100
    private let cellHeight: CGFloat = 180
    
    @ObservedObject var viewModel: T
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center, spacing: 16) {
                SearchBar(
                    placeholder: self.viewModel.searchPlaceholder,
                    text: $viewModel.searchText)
                .frame(height: 60)
                
                if self.viewModel.state == .loading {
                    self.loadingView
                } else {
                    if !self.viewModel.items.isEmpty {
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(0..<self.viewModel.items.count, id: \.self) { index in
                                    HStack(alignment: .center, spacing: 10) {
                                        ForEach(0...2, id: \.self) { idx in
                                            if self.viewModel.items[index].indices.contains(idx) {
                                                self.cellLink(using: self.viewModel.items[index][idx])
                                            } else {
                                                self.emptyCell
                                            }
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
                        Spacer()
                    }
                }
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
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
    
    private var emptyCell: some View {
        Rectangle()
            .fill(.clear)
            .frame(
                width: self.cellWidth,
                height: self.cellHeight)
    }
    
    private func cellLink(
        using movie: MovieBase
    ) -> some View {
        return NavigationLink {
            MovieDetailView(
                viewModel: MovieDetailViewModel(
                    selectedType: self.viewModel.selectedType,
                    movie: movie
                )
            )
        } label: {
            self.cell(using: movie)
        }

    }
    
    private func cell(using movie: MovieBase) -> some View {
        return VStack(alignment: .leading) {
            Group {
                if movie.posterURL != nil {
                    self.poster(
                        title: movie.getTitle(),
                        url: movie.posterURL)
                } else {
                    self.posterPlaceholder(
                        using: movie.getTitle())
                }
            }
            .frame(
                width: self.cellWidth,
                height: 160)
            .background(Color.tDarkGray)
            .cornerRadius(8)
            
            Text(movie.getTitle())
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
        return WebImage(
            url: url,
            config: {
                AnyView(
                    AnyView($0.resizable())
                        .scaledToFill()
                )
            },
            placeholder: {
                AnyView(
                    AnyView(
                        self.posterPlaceholder(using: title)
                    )
                )
            }
        )
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
        SearchView(viewModel: SearchViewModel())
    }
}
