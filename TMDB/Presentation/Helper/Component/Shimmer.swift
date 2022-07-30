//
//  Shimmer.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct Shimmer: View {
    @State private var opacity: Double = 0.25
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.tDarkGray)
            .opacity(self.opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 0.9)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = 1
                }
            }
    }
}

struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Shimmer()
                    .frame(width: 100, height: 100)

                Shimmer()
                    .frame(height: 20)

                Shimmer()
                    .frame(height: 20)

                Shimmer()
                    .frame(height: 100)
            }
            .padding()

        }
    }
}
