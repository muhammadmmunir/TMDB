//
//  WebImageCache.swift
//  TMDB
//
//  Created by Muhammad M Munir on 01/08/22.
//

import Foundation
import UIKit

class WebImageCache {
    var cache = NSCache<NSString, UIImage>()

    func get(forKey key: String) -> UIImage? {
        return self.cache.object(forKey: NSString(string: key))
    }

    func set(forKey key: String, image: UIImage) {
        self.cache.setObject(image, forKey: NSString(string: key))
    }
}

extension WebImageCache {
    
    private static var cache = WebImageCache()
    
    static func getCache() -> WebImageCache {
        return self.cache
    }
}
