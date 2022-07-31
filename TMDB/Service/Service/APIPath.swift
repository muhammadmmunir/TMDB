//
//  APIPath.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

enum APIPath {
    enum Movie: String {
        case nowPlaying = "movie/now_playing"
        case trending = "trending/movie/day"
        case discover = "discover/movie"
        case reviews = "movie/{movie_id}/reviews"
        case search = "search/movie"
    }
    enum TVShow: String {
        case nowPlaying = "tv/on_the_air"
        case trending = "trending/tv/day"
        case discover = "discover/tv"
        case reviews = "tv/{tv_id}/reviews"
        case search = "search/tv"
    }
}
