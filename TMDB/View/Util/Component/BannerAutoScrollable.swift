//
//  BannerAutoScrollable.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct BannerAutoScrollable: View {
    private let timer = Timer
        .publish(every: 5, on: .main, in: .common)
        .autoconnect()
    @State private var currentIndex = 0
    
    let selectedType: Int
    @Binding var movies: [MovieBase]
    @Binding var state: APIServiceState
    
    var body: some View {
        Group {
            if self.state == .loading {
                Shimmer()
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(self.movies, id: \.id) { movie in
                        Banner(
                            selectedType: selectedType,
                            movie: movie
                        )
                    }
                }
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
            currentIndex = currentIndex < movies.count ? currentIndex + 1 : 0
        }
    }
}

struct BannerAutoScrollable_Previews: PreviewProvider {
    static var previews: some View {
        BannerAutoScrollable(
            selectedType: 0,
            movies: .constant([]),
            state: .constant(.initial)
        )
    }
}
