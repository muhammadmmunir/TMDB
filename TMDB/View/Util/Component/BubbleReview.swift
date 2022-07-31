//
//  BubbleReview.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BubbleReview: View {
    let reviewerAvatar: URL?
    let reviewerName: String
    let review: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .foregroundColor(.tWhite)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    WebImage(url: reviewerAvatar)
                        .resizable()
                        .placeholder {
                            Image(systemName: "person.circle")
                                .resizable()
                                .foregroundColor(.tDarkGray)
                                .frame(
                                    width: 25,
                                    height: 25
                                )
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.25))
                        .scaledToFill()
                        .frame(
                            width: 25,
                            height: 25,
                            alignment: .center
                        )
                        .clipShape(Circle())
                    
                    Text(reviewerName)
                        .font(.tSubheadline)
                        .foregroundColor(.tBlack)
                        .lineLimit(1)
                }
                
                Text(review)
                    .font(.tCaption)
                    .foregroundColor(.tBlack)
                    .multilineTextAlignment(.leading)
            }.padding(
                EdgeInsets(
                    top: 8,
                    leading: 8,
                    bottom: 8,
                    trailing: 8)
            )
        }
    }
}

struct BubbleReview_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BubbleReview(
                reviewerAvatar: nil,
                reviewerName: "Bruce Wayne",
                review: "No comment.")
        }.preferredColorScheme(.dark)
    }
}
