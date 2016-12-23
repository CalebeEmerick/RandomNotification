//
//  Service.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

struct Service {
    
    private let url = "http://lorempixel.com/index.php?generator=1&x=640&y=480&cat="
    
    func getImage(from category: Category, completion: @escaping (UIImage?) -> Void) {
        
        let endPoint = "\(url)\(category.imageUrl)"
        
        ImageDownloader.shared.download(from: endPoint) { image in
            
            completion(image)
        }
    }
}
