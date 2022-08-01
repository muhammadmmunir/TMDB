//
//  WebImageViewModel.swift
//  TMDB
//
//  Created by Muhammad M Munir on 01/08/22.
//

import UIKit
import Combine

class WebImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private var cache = WebImageCache.getCache()
    private var cancellable: AnyCancellable?
    
    private(set) var isLoading: Bool = false
    
    private static let imageQueue = DispatchQueue(label: "image-cache")
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func load() {
        guard !self.isLoading else { return }
        
        guard !self.loadFromCache() else { return }
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: self.url)
            .retry(10)
            .subscribe(on: WebImageViewModel.imageQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(
                receiveSubscription: { [unowned self] _ in self.startLoading() },
                receiveOutput: { [unowned self] in self.cacheImage($0) },
                receiveCompletion: { [unowned self] _ in self.stopLoading() },
                receiveCancel: { [unowned self] in self.stopLoading() })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
    
    private func loadFromCache() -> Bool {
        printIfDebug("WebImage.loadCacheImage.\(self.url.absoluteString)")
        if let imageCache = self.cache.get(forKey: self.url.absoluteString) {
            printIfDebug("WebImage.loadCacheImage.found")
            self.image = imageCache
            return true
        } else {
            printIfDebug("WebImage.loadCacheImage.notFound")
            return false
        }
    }
    
    private func cacheImage(_ image: UIImage?) {
        if let image = image {
            self.cache.set(forKey: self.url.absoluteString, image: image)
        }
    }
    
    private func startLoading() {
        self.isLoading = true
    }
    
    private func stopLoading() {
        self.isLoading = false
    }
}
