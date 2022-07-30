//
//  TVShowRequestDTO.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

struct TVShowRequestDTO: Encodable {
    let query: String
    let page: Int
}
