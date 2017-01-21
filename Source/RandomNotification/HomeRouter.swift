//
//  HomeRouter.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

struct HomeRouter {
    
    private weak var controller: UIViewController?
    
    init(pass controller: UIViewController?) {
        self.controller = controller
    }
    
    func showDetail(with image: UIImage?, title: String) {
        
        let detailController = Storyboard.shared.createViewController(by: DetailController.self)
        
        detailController.image = image
        detailController.title = title
        
        controller?.show(detailController, sender: nil)
    }
}
