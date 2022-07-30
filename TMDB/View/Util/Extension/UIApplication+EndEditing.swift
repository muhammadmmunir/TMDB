//
//  UIApplication+EndEditing.swift
//  TMDB
//
//  Created by Muhammad M Munir on 30/07/22.
//

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}
