//
//  AllReviewView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct AllReviewView: View {
    private let wording: Wording
    
    init(wording: Wording = .init()) {
        self.wording = wording
    }
    
    var body: some View {
        VStack {
            Text("Review")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(self.wording.str(.generalAllReview))
    }
}

struct AllReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AllReviewView()
    }
}
