//
//  AllReviewViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol AllReviewViewModelInterface {
    var reviews: [Review] { get set }
    var title: String { get }
}

final class AllReviewViewModel: AllReviewViewModelInterface {
    var reviews = [Review]()
    var title: String {
        self.wording.str(.generalAllReview)
    }
    
    let wording: Wording
    
    init(
        wording: Wording = .init(),
        reviews: [Review] = []
    ) {
        self.wording = wording
        self.reviews = reviews
    }
}
