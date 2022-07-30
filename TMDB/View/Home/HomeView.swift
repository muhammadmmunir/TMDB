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
        BannerAutoScrollable(movies: [])
    }
    
    private var popularMovies: some View {
        HorizontalSectionList(
            viewModel: HorizontalSectionListViewModel(
                movies: []
            ),
            sectionTitle: Wording().str(.generalPopular))
    }
    
    private var discoverMovies: some View {
        HorizontalSectionList(
            viewModel: HorizontalSectionListViewModel(
                movies: []
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
        BannerAutoScrollable(movies: [])
    }
    
    private var popularTvShows: some View {
        HorizontalSectionList(
            viewModel: HorizontalSectionListViewModel(
                movies: []
            ),
            sectionTitle: Wording().str(.generalPopular))
    }
    
    private var discoverTvShows: some View {
        HorizontalSectionList(
            viewModel: HorizontalSectionListViewModel(
                movies: []
            ),
            sectionTitle: Wording().str(.generalDiscover))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
