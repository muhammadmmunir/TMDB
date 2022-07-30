//
//  BannerAutoScrollable.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct BannerAutoScrollable: View {
    private let movies: [Movie]
    private let timer = Timer
        .publish(every: 5, on: .main, in: .common)
        .autoconnect()
    @State private var currentIndex = 0
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(self.movies) { movie in
                Banner(
                    url: movie.posterUrl,
                    title: movie.title)
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
        BannerAutoScrollable(movies: [
            Movie(id: 1, title: "One Piece 1", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 2, title: "One Piece 2", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 3, title: "One Piece 3", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 4, title: "One Piece 4", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 5, title: "One Piece 5", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1312156301783.jpg")
        ])
    }
}
