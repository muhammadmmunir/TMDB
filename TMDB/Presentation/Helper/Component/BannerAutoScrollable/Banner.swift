//
//  Banner.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct Banner: View {
    static let width: CGFloat = .infinity
    static let height: CGFloat = 250
    
    let url: URL?
    let title: String
    
    var body: some View {
        NavigationLink(destination: {
            MovieDetailView()
        }, label: {
            self.banner
        })
    }
    
    private var banner: some View {
        Group {
            if self.url != nil {
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
                WebImage(url: self.url)
                    .resizable()
                    .placeholder {
                        self.bannerPlaceholder
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.25))
                    .scaledToFill()
                    .frame(
                        width: geo.size.width,
                        height: Banner.height)
                    .clipShape(Rectangle())
            }
            
            self.bannerTitle
        }
    }
    
    private var bannerPlaceholder: some View {
        Text(self.title)
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
                
                Text(self.title)
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
            url: .init(string: "https://www.joblo.com/wp-content/uploads/2014/10/interstellar-quad-nolan-1.jpg"),
            title: "Interstellar")
    }
}
