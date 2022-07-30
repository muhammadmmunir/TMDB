//
//  PosterImage.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PosterImage: View {
    static let width: CGFloat = 130
    static let height: CGFloat = 200
    
    let url: URL?
    let title: String
    
    init(url: URL?, title: String) {
        self.url = url
        self.title = title
    }
    
    var body: some View {
        NavigationLink(destination: {
            MovieDetailView()
        }, label: {
            self.poster
        })
    }
    
    private var poster: some View {
        Group {
            if self.url != nil {
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
        WebImage(url: self.url)
            .resizable()
            .placeholder {
                self.posterPlaceholder
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.25))
            .scaledToFill()
    }
    
    private var posterPlaceholder: some View {
        Text(self.title)
            .font(.tTitle2).bold()
            .multilineTextAlignment(.center)
            .foregroundColor(.tWhite)
            .frame(width: 120)
    }
}

struct PosterImage_Previews: PreviewProvider {
    static var previews: some View {
        PosterImage(
            url: .init(string: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            title: "One Piece Film: Red"
        )
    }
}
