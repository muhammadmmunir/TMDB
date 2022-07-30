//
//  BannerAutoScrollable.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct BannerAutoScrollable: View {
    private let movies: [MovieBase]
    private let timer = Timer
        .publish(every: 5, on: .main, in: .common)
        .autoconnect()
    @State private var currentIndex = 0
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(self.movies, id: \.id) { movie in
                Banner(
                    url: movie.backdropURL,
                    title: movie.getTitle())
            }
        }
        .frame(height: Banner.height)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onReceive(self.timer) { _ in
            next()
        }
    }
    
    private func next() {
        withAnimation {
            currentIndex = currentIndex < self.movies.count ? currentIndex + 1 : 0
        }
    }
}

struct BannerAutoScrollable_Previews: PreviewProvider {
    static var previews: some View {
        BannerAutoScrollable(movies: [])
    }
}
