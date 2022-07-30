//
//  HomeHeader.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct HomeHeader: View {
    let searchDestination: () -> SearchView
    let moviesAction: () -> Void
    let tvShowsAction: () -> Void
    @Binding var selectedType: Int
    
    private let wording: Wording
    
    init(
        wording: Wording = .init(),
        searchDestination: @escaping () -> SearchView,
        moviesAction: @escaping () -> Void,
        tvShowsAction: @escaping () -> Void,
        selectedType: Binding<Int>
    ) {
        self.wording = wording
        self.searchDestination = searchDestination
        self.moviesAction = moviesAction
        self.tvShowsAction = tvShowsAction
        self._selectedType = selectedType
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                self.title
                Spacer()
                self.searchButton
            }
            
            Spacer()
                .frame(height: 28)
            HStack {
                self.moviesButton
                Spacer()
                self.tvShowsButton
            }
        }
        .padding(
            EdgeInsets(
                top: 24, leading: 16,
                bottom: 10, trailing: 16))
        .background(Color.tBlack)
    }
    
    private var title: some View {
        Text(self.wording.str(.generalTmdb))
            .font(.tTitle.bold())
            .foregroundColor(.tTamarillo)
            .multilineTextAlignment(.leading)
    }
    
    private var searchButton: some View {
        NavigationLink(destination: self.searchDestination) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.tWhite)
        }
    }
    
    private var moviesButton: some View {
        Button(
            self.wording.str(.generalMovies),
            action: self.moviesAction)
        .frame(maxWidth: .infinity)
        .font(.tTitle3.weight(.bold))
        .foregroundColor(
            self.selectedType == 0 ? .tRed : .tWhite
        )
    }
    
    private var tvShowsButton: some View {
        Button(
            self.wording.str(.generalTVShows),
            action: self.tvShowsAction)
        .frame(maxWidth: .infinity)
        .font(.tTitle3.weight(.bold))
        .foregroundColor(
            self.selectedType == 1 ? .tRed : .tWhite
        )
    }
}

struct HomeHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeader(
            searchDestination: {
                SearchView()
            },
            moviesAction: {},
            tvShowsAction: {},
            selectedType: .constant(0)
        )
    }
}
