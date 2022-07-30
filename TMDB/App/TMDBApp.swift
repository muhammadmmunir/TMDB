//
//  TMDBApp.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

@main
struct TMDBApp: App {
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }
    
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
}
