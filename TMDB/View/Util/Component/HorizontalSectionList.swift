//
//  HorizontalSectionList.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct HorizontalSectionList: View {
    let sectionTitle: String
    @Binding var movies: [MovieBase]
    @Binding var state: APIServiceState
        
    var body: some View {
        if self.state == .loading {
            self.shimmer
        } else {
            if !self.movies.isEmpty {
                self.list
            } else {
                self.empty
            }
        }
    }
    
    private var shimmer: some View {
        VStack(alignment: .leading, spacing: 12) {
            Shimmer().frame(height: 32)
            Shimmer().frame(height: PosterImage.height)
        }
        .padding([.leading, .trailing], 12)
        .transition(
            AnyTransition
                .opacity
                .animation(.easeInOut(duration: 0.5)))
    }
    
    private var list: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(self.sectionTitle)
                .padding(.leading, 16)
                .font(.tTitle2.bold())
                .foregroundColor(.tWhite)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(self.movies, id: \.id) { movie in
                        PosterImage(
                            url: movie.posterURL,
                            title: movie.getTitle())
                    }
                }
                .frame(height: PosterImage.height)
                .padding([.leading, .trailing], 12)
            }
        }
        .transition(
            AnyTransition
                .opacity
                .animation(.easeInOut(duration: 0.5)))
    }
    
    private var empty: some View {
        Rectangle()
            .fill(Color.clear)
            .transition(
                AnyTransition
                    .opacity
                    .animation(.easeInOut(duration: 0.5)))
    }
}

struct HorizontalSectionList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            
            HorizontalSectionList(
                sectionTitle: "",
                movies: .constant([]),
                state: .constant(.initial))
        }.preferredColorScheme(.dark)
    }
}
