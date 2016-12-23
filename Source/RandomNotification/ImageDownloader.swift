//
//  ImageDownloader.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class ImageDownloader {
    
    private init() { }
    static let shared = ImageDownloader()
    fileprivate let cache = NSCache<AnyObject, AnyObject>()
    
    func download(from url: String, completion: @escaping (UIImage?) -> Void) {
        
        if isCached(url) {
            
            let cachedImage = retrieveCachedImage(from: url)
            completion(cachedImage)
        }
        else {
            
            downloadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    completion(image)
                    self?.makeCache(for: url, image: image)
                }
            }
        }
    }
}

extension ImageDownloader {
    
    fileprivate func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        
        Just.get(url) { result in
            
            DispatchQueue.main.async {
                
                guard let data = result.content else {
                    completion(nil)
                    return
                }
                
                let image = UIImage(data: data)
                completion(image)
            }
        }
    }
    
    fileprivate func makeCache(for url: String, image: UIImage?) {
        
        let item = CacheItem(url: url, image: image)
        
        cache.setObject(item, forKey: item.urlObject)
    }
    
    fileprivate func retrieveCachedImage(from url: String) -> UIImage? {
        
        let urlObject = url as AnyObject
        guard let item = cache.object(forKey: urlObject) as? CacheItem else { return nil }
        
        return item.image
    }
    
    fileprivate func isCached(_ url: String) -> Bool {
        
        let urlObject = url as AnyObject
        return cache.object(forKey: urlObject) != nil
    }
}
