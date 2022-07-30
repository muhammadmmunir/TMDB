//
//  ProfileView.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct ProfileView: View {
    private let wording: Wording
    
    init(wording: Wording = .init()) {
        self.wording = wording
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.wording.str(.generalProfile))
                .font(.tTitle)
                .foregroundColor(.tWhite)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
