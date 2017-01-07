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
    
    fileprivate(set) var currentImage: UIImage?
    
    lazy var imageUrl: URL = {
        
       return shared.directory.appendingPathComponent(shared.imageName)
    }()
    
    fileprivate lazy var directory: URL = {
        
        return shared.getDocumentsDirectory()
    }()
}

extension RFileManager {

    func save(image: UIImage) {
    
        guard let data = UIImageJPEGRepresentation(image, 1) else { return }
        
        do {
            self.currentImage = image
            try data.write(to: imageUrl)
        }
        catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func retrieveImageUrl() -> URL {
        
        let imageUrl = URL(fileURLWithPath: directory.absoluteString).appendingPathComponent(imageName)
        return imageUrl
    }
    
//    func getImage(from url: URL) -> UIImage? {
//        
//        _ = imageUrl.startAccessingSecurityScopedResource()
//        let data = try? Data(contentsOf: imageUrl)
//        print(imageUrl)
//        
//        return nil
//        
//        do {
//            let data = try Data(contentsOf: imageUrl)
//            return UIImage(data: data)
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
//        
//        guard let imageData = try? Data(contentsOf: url) else { return nil }
//        let image = UIImage(data: imageData)
//        
//        return image
//    }
    
    fileprivate func getDocumentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
}
