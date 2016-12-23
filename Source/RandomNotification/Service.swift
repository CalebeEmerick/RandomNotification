//
//  Service.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

struct Service {
    
    private let url = "http://lorempixel.com/"
    
    func getImage(from category: Category, isGrayScale: Bool, completion: @escaping (UIImage?) -> Void) {
        
        let endPoint = makeUrl(from: category.imageUrl, isGrayScale: isGrayScale)
        getImageUrl(from: endPoint) { result in
            
            let imageUrl = "\(self.url)\(result)"
            
            ImageDownloader.shared.download(from: imageUrl) { image in
                
                completion(image)
            }
        }
    }
    
    private func getImageUrl(from url: String, completion: @escaping (String) -> Void) {
        
        Just.get(url) { result in
            
            guard let data = result.content else { return }
            guard let resultString = String(data: data, encoding: .utf8) else { return }
            let imageUrl = self.formatString(from: resultString)
            
            completion(imageUrl)
        }
    }
    
    private func formatString(from string: String) -> String {
        
        guard !string.isEmpty else { return "" }
        
        let newString = string.components(separatedBy: "\"")
        let stringFormatted = newString[1]
        
        return stringFormatted
    }
    
    private func makeUrl(from category: String, isGrayScale: Bool) -> String {
        
        let grayScale = convertToInt(bool: isGrayScale)
        let newUrl = "\(url)index.php?generator=1&x=640&y=480&"
        let category = "\(newUrl)cat=\(category)"
        let finalUrl = "\(category)&gray=\(grayScale)"
        
        return finalUrl
    }
    
    private func convertToInt(bool: Bool) -> Int {
        
        if bool { return 1 }
        
        return 0
    }
}
