//
//  CacheItem.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class CacheItem : AnyObject {
    
    let url: String
    let image: UIImage?
    
    init(url: String, image: UIImage?) {
        
        self.url = url
        self.image = image
    }
}

extension CacheItem {
    
    var urlObject: AnyObject {
        
        return url as AnyObject
    }
}
