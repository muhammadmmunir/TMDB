//
//  Banner.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct Banner: View {
    static let width: CGFloat = .infinity
    static let height: CGFloat = 250
    
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
            self.banner
        })
    }
    
    private var banner: some View {
        Group {
            if self.movie.backdropURL != nil {
                self.bannerImage
            } else {
                self.bannerPlaceholder
            }
        }
        .frame(
            maxWidth: Banner.width,
            maxHeight: Banner.height)
        .background(Color.tBlack)
    }
    
    private var bannerImage: some View {
        ZStack(alignment: .top) {
            GeometryReader { geo in
                WebImage(
                    url: self.movie.backdropURL,
                    config: {
                        AnyView(
                            AnyView($0.resizable())
                                .scaledToFill()
                                .frame(
                                    width: geo.size.width,
                                    height: Banner.height)
                        )
                    },
                    placeholder: {
                        AnyView(
                            AnyView(self.bannerPlaceholder)
                        )
                    }
                )
            }
            
            self.bannerTitle
        }
    }
    
    private var bannerPlaceholder: some View {
        Text(self.movie.getTitle())
            .font(.tTitle2).bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.tWhite)
            .frame(
                maxWidth: Banner.width,
                maxHeight: Banner.height)
    }
    
    private var bannerTitle: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient:
                            Gradient(
                                colors: [.tBlack, .clear]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .frame(height: 50)
                .offset(x: 0, y: 0)
            
            ZStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient:
                                Gradient(
                                    colors: [.clear, .tBlack]),
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                
                Text(self.movie.getTitle())
                    .font(.tSubheadline).bold()
                    .foregroundColor(.tWhite)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .cornerRadius(8)
            }
            .frame(height: 50)
            .offset(x: 0, y: Banner.height-50)
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner(
            selectedType: 0,
            movie: .init()
        )
    }
}
