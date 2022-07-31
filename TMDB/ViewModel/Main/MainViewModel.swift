//
//  MainViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

protocol MainViewModelInterface: ObservableObject {
    var selectedTab: Int { get set }
}

final class MainViewModel: MainViewModelInterface {
    @Published var selectedTab: Int = 0
}
