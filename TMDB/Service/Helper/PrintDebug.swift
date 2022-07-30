//
//  PrintDebug.swift
//  TMDB
//
//  Created by Muhammad M Munir on 31/07/22.
//

import Foundation

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}
