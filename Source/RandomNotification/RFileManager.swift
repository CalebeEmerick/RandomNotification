//
//  RFileManager.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class RFileManager {
    
    init() { }
    static let shared = RFileManager()
    fileprivate let imageName = "image.jpg"
    
    fileprivate lazy var directory: URL = {
        
        return shared.getDocumentsDirectory()
    }()
}

extension RFileManager {

    func save(image: UIImage) {
    
        guard let data = UIImageJPEGRepresentation(image, 1) else { return }
        
        let url = directory.appendingPathComponent(imageName)
        
        do {
            try data.write(to: url)
        }
        catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func retrieveImageUrl() -> URL {
        
        let imageUrl = URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(imageName)
        return imageUrl
    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
}
