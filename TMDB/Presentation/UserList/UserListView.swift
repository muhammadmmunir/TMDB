//
//  UserListView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct UserListView: View {
    private let wording: Wording
    
    init(wording: Wording = .init()) {
        self.wording = wording
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.tBlack.edgesIgnoringSafeArea(.all)
                VStack {
                    Text(self.wording.str(.generalTmdb))
                        .font(.tTitle.bold())
                        .foregroundColor(.tTamarillo)
                    
                    Spacer()
                        .frame(height: 100)
                    NavigationLink {
                        MainView()
                    } label: {
                        VStack(spacing: 10) {
                            Image("batman")
                                .resizable()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.tWhite, lineWidth: 2)
                                )
                                .frame(width: 60, height: 60)
                            Text(self.wording.str(.generalGuest))
                                .font(.tCaption).bold()
                                .foregroundColor(.tWhite)
                        }
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
