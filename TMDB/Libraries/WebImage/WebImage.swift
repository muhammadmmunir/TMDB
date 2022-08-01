//
//  WebImage.swift
//  TMDB
//
//  Created by Muhammad M Munir on 01/08/22.
//

import SwiftUI

struct WebImage: View {
    @ObservedObject private var viewModel: WebImageViewModel
    
    @State var isAnimating: Bool = false
    private let config: (Image) -> AnyView
    private let placeholder: (() -> AnyView)?
    private let defaultURL: URL = URL(string: "https://i.pinimg.com/736x/d2/52/49/d25249ce7b98705d9e9ca48d461857bb.jpg")!
    
    init(
        url: URL?,
        config: @escaping (Image) -> AnyView = { AnyView($0) },
        placeholder: (() -> AnyView)? = nil
    ) {
        self.config = config
        self.placeholder = placeholder
        self.viewModel = WebImageViewModel(
            url: url ?? self.defaultURL)
    }
    
    var body: some View {
        Group {
            if self.viewModel.image != nil {
                self.config(
                    Image(uiImage: self.viewModel.image!)
                        .renderingMode(.original)
                )
            } else {
                if self.placeholder != nil {
                    self.placeholder?()
                        .onAppear { self.viewModel.load() }
                        .onDisappear { self.viewModel.cancel() }
                } else {
                    ActivityIndicator(isAnimating: self.$isAnimating)
                        .onAppear { self.viewModel.load() }
                        .onDisappear { self.viewModel.cancel() }
                }
            }
        }
        .transition(.opacity)
        .animation(Animation.linear(duration: 0.25))
    }
}

struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage(
            url: URL(string: "https://cdf.orami.co.id/unsafe/cdn-cas.orami.co.id/parenting/images/batman-film.width-800.jpegquality-80.jpg"),
            config: {
                AnyView(
                    AnyView($0.resizable())
                        .frame(width: 200, height: 200)
                )
            },
            placeholder: {
                AnyView(
                    Rectangle()
                        .fill(Color.tRed)
                        .frame(width: 200, height: 200)
                )
            }
        )
    }
}
