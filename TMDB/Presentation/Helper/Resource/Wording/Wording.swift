//
//  Wording.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import Foundation

struct Wording {
    private let tableName = "Localizable"
    private let bundle: Bundle
    private let local: Locale
    
    init(
        bundle: Bundle = Bundle.main,
        local: Locale = Locale.current
    ) {
        self.bundle = bundle
        self.local = local
    }
    
    func str(_ key: WordingKey) -> String {
        let format = NSLocalizedString(
            key.rawValue,
            tableName: self.tableName,
            bundle: self.bundle,
            comment: "")
        return String(format: format, locale: self.local)
    }
}
