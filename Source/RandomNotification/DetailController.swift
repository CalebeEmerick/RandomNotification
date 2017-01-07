//
//  DetailController.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class DetailController : UIViewController {

    @IBOutlet fileprivate weak var picture: UIImageView!
    
    fileprivate var identifier: String { return "contents" }
    var image: UIImage?
}

extension DetailController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateImage()
    }
}

extension DetailController {

    fileprivate func updateImage() {
        DispatchQueue.main.async {
            
            let fade = CABasicAnimation(keyPath: self.identifier)
            
            fade.fromValue = self.picture.image
            fade.toValue = self.image
            fade.duration = 0.3
        
            self.picture.layer.add(fade, forKey: self.identifier)
            self.picture.image = self.image
        }
    }
}
