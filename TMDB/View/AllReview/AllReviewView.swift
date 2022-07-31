//
//  AllReviewView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct AllReviewView: View {
    let viewModel: AllReviewViewModelInterface
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(self.viewModel.reviews) { review in
                    BubbleReview(
                        reviewerAvatar: review.avatarURL,
                        reviewerName: review.name ?? "",
                        review: review.content ?? "")
                }
            }
            .padding(
                EdgeInsets(
                    top: 16,
                    leading: 16,
                    bottom: 16,
                    trailing: 16)
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(self.viewModel.title)
        }
    }
}

struct AllReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AllReviewView(viewModel: AllReviewViewModel())
    }
}
