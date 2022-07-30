//
//  SearchBar.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import SwiftUI

struct SearchBar: View {
    private let wording: Wording
    @Binding var text: String
    
    init(
        wording: Wording = .init(),
        text: Binding<String> = .constant(Wording().str(.generalTyping))
    ) {
        self.wording = wording
        _text = text
    }

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.tLightGray)

                TextField(
                    wording.str(.generalTyping),
                    text: $text
                )
                .foregroundColor(.tLightGray)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.tLightGray)
                        
                    })
                } else {
                    EmptyView()
                }
            }
            .padding(
                EdgeInsets(
                    top: 12, leading: 12, bottom: 12, trailing: 12
                )
            )
            .foregroundColor(.tLightGray)
            .background(Color.tDarkGray)
            .cornerRadius(8)
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
