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
    
    var image: UIImage? { didSet { updateUI() } }
}

extension DetailController {
    
    fileprivate func updateUI() {
        
        guard let image = image else { return }
        
        self.picture.image = image
    }
}
