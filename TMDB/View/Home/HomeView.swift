//
//  HomeView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct HomeView<T>: View where T: HomeViewModelInterface {
    @ObservedObject var viewModel: T
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                self.header
                
                VStack(spacing: 16) {
                    BannerAutoScrollable(
                        movies: $viewModel.nowPlayingItems,
                        state: $viewModel.nowPlayingState
                    )
                    HorizontalSectionList(
                        sectionTitle: viewModel.trendingTitle,
                        movies: $viewModel.trendingItems,
                        state: $viewModel.trendingState)
                    HorizontalSectionList(
                        sectionTitle: viewModel.discoverTitle,
                        movies: $viewModel.discoverItems,
                        state: $viewModel.discoverState)
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private var header: some View {
        VStack {
            HomeHeader(searchDestination: {
                SearchView(
                    viewModel: SearchViewModel(
                        selectedType: self.viewModel.selectedType
                    )
                )
            }, moviesAction: {
                self.viewModel.selectedType = 0
            }, tvShowsAction: {
                self.viewModel.selectedType = 1
            }, selectedType: self.$viewModel.selectedType)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
