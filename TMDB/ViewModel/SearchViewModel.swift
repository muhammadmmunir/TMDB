//
//  SearchViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import Combine

class SearchViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var searchText = ""
//    @Published var items = [[Movie]]()
    @Published var items: [[Movie]] = [
        [
            Movie(id: 1, title: "One Piece 1", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 2, title: "Interstellar 1", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
            Movie(id: 3, title: "One Piece 3", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg")
        ],
        [
            Movie(id: 4, title: "Interstellar 2", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
            Movie(id: 5, title: "The Dark Knight 1", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg"),
            Movie(id: 6, title: "The Dark Knight 2", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg")
        ],
        [
            Movie(id: 7, title: "One Piece 1", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg"),
            Movie(id: 8, title: "Interstellar 1", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
            Movie(id: 9, title: "One Piece 3", poster: "https://assets.promediateknologi.com/crop/0x0:0x0/x/photo/2022/07/11/1356301783.jpg")
        ],
        [
            Movie(id: 10, title: "Interstellar 2", poster: "https://cdn.europosters.eu/image/750/posters/interstellar-ice-walk-i23290.jpg"),
            Movie(id: 11, title: "The Dark Knight 1", poster: "https://i.pinimg.com/originals/cc/c6/35/ccc63593fe4c0f84bad83ce408a6674b.jpg"),
            Movie(id: 12, title: "The Dark Knight 2", poster: "")
        ],
    ]
    @Published var state: State = .initial
}
