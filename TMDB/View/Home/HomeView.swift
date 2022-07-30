//
//  HomeView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct HomeView: View {
    @State public var selectedType: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                self.header
                self.content
            }
            .background(Color.tBlack)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private var header: some View {
        VStack {
            HomeHeader(searchDestination: {
                SearchView()
            }, moviesAction: {
                self.selectedType = 0
            }, tvShowsAction: {
                self.selectedType = 1
            }, selectedType: self.$selectedType)
        }
    }
    
    private var content: AnyView {
        if self.selectedType == 0 {
            return AnyView(self.movies)
        } else {
            return AnyView(self.tvShows)
        }
    }
    
    private var movies: some View {
        VStack(spacing: 16) {
            self.bannerMovies
            self.popularMovies
            self.discoverMovies
        }
    }
    
    private var bannerMovies: some View {
        BannerAutoScrollable(movies: [
            Movie(id: 1, title: "One Piece 1", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 2, title: "One Piece 2", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 3, title: "One Piece 3", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 4, title: "One Piece 4", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 5, title: "One Piece 5", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1312156301783.jpg")
        ])
    }
    
    private var popularMovies: some View {
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
    }
    
    private var discoverMovies: some View {
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
            sectionTitle: Wording().str(.generalDiscover))
    }
    
    private var tvShows: some View {
        VStack(spacing: 16) {
            self.bannerTvShows
            self.popularTvShows
            self.discoverTvShows
        }
    }
    
    private var bannerTvShows: some View {
        BannerAutoScrollable(movies: [
            Movie(id: 4, title: "Interstellar 2", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
            Movie(id: 5, title: "The Dark Knight 1", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg"),
            Movie(id: 6, title: "The Dark Knight 2", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg")
        ])
    }
    
    private var popularTvShows: some View {
        HorizontalSectionList(
            viewModel: HorizontalSectionListViewModel(
                movies: [
                    Movie(id: 4, title: "Interstellar 2", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
                    Movie(id: 5, title: "The Dark Knight 1", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg"),
                    Movie(id: 6, title: "The Dark Knight 2", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg")
                ]
            ),
            sectionTitle: Wording().str(.generalPopular))
    }
    
    private var discoverTvShows: some View {
        HorizontalSectionList(
            viewModel: HorizontalSectionListViewModel(
                movies: [
                    Movie(id: 4, title: "Interstellar 2", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
                    Movie(id: 5, title: "The Dark Knight 1", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg"),
                    Movie(id: 6, title: "The Dark Knight 2", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg")
                ]
            ),
            sectionTitle: Wording().str(.generalDiscover))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
