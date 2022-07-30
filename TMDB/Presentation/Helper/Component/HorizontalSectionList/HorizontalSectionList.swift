//
//  HorizontalSectionList.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct HorizontalSectionList: View {
    @ObservedObject var viewModel: HorizontalSectionListViewModel
    private let sectionTitle: String
    
    init(
        viewModel: HorizontalSectionListViewModel,
        sectionTitle: String
    ) {
        self.viewModel = viewModel
        self.sectionTitle = sectionTitle
    }
    
    var body: some View {
        if self.viewModel.state == .loading {
            self.shimmer
        } else {
            if !self.viewModel.movies.isEmpty {
                self.list
            } else {
                self.empty
            }
        }
    }
    
    private var shimmer: some View {
        VStack(alignment: .leading, spacing: 12) {
            Shimmer().frame(height: 32)
            Shimmer().frame(height: PosterImage.height)
        }
        .padding([.leading, .trailing], 12)
        .transition(
            AnyTransition
                .opacity
                .animation(.easeInOut(duration: 0.5)))
    }
    
    private var list: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(self.sectionTitle)
                .padding(.leading, 16)
                .font(.tTitle2.bold())
                .foregroundColor(.tWhite)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(self.viewModel.movies) { movie in
                        PosterImage(
                            url: movie.posterUrl,
                            title: movie.title)
                    }
                }
                .frame(height: PosterImage.height)
                .padding([.leading, .trailing], 12)
            }
        }
        .transition(
            AnyTransition
                .opacity
                .animation(.easeInOut(duration: 0.5)))
    }
    
    private var empty: some View {
        Rectangle()
            .fill(Color.clear)
            .transition(
                AnyTransition
                    .opacity
                    .animation(.easeInOut(duration: 0.5)))
    }
}

struct HorizontalSectionList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            
            HorizontalSectionList(
                viewModel: HorizontalSectionListViewModel(
                    movies: [
                        Movie(id: 1, title: "One Piece 1", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
                        Movie(id: 2, title: "One Piece 2", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
                        Movie(id: 3, title: "One Piece 3", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
                        Movie(id: 4, title: "One Piece 4", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
                        Movie(id: 5, title: "One Piece 5", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1312156301783.jpg")
                    ]
                ),
                sectionTitle: Wording().str(.generalPopular))
        }.preferredColorScheme(.dark)
    }
}
