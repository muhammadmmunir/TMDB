//
//  PosterImage.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct PosterImage: View {
    static let width: CGFloat = 130
    static let height: CGFloat = 200
    
    let selectedType: Int
    let movie: MovieBase
    
    var body: some View {
        NavigationLink(destination: {
            MovieDetailView(
                viewModel: MovieDetailViewModel(
                    selectedType: selectedType,
                    movie: movie
                )
            )
        }, label: {
            self.poster
        })
    }
    
    private var poster: some View {
        Group {
            if self.movie.posterURL != nil {
                self.posterImage
            } else {
                self.posterPlaceholder
            }
        }
        .frame(
            width: PosterImage.width,
            height: PosterImage.height)
        .background(Color.tDarkGray)
        .cornerRadius(8)
    }
    
    private var posterImage: some View {
        WebImage(
            url: self.movie.posterURL,
            config: {
                AnyView(
                    AnyView($0.resizable())
                        .scaledToFill()
                )
            },
            placeholder: {
                AnyView(
                    AnyView(self.posterPlaceholder)
                )
            }
        )
    }
    
    private var posterPlaceholder: some View {
        Text(self.movie.getTitle())
            .font(.tTitle2).bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.tWhite)
            .frame(width: 120)
    }
}

struct PosterImage_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(
            selectedType: 0,
            movie: .init()
        )
    }
}
