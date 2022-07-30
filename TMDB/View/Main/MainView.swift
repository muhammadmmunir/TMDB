//
//  MainView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct MainView: View {
    @State public var selectedTab: Int = 0
    private let wording: Wording
    
    init(wording: Wording = .init()) {
        self.wording = wording
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                ZStack {
                    HomeView()
                }
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
                
                ZStack {
                    ProfileView()
                }
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(1)
            }
            .accentColor(.tRed)
            .font(.tHeadline)
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
