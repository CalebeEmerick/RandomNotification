//
//  Storyboard.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class Storyboard {
    
    private init() { }
    static let shared = Storyboard()
    
    let main = UIStoryboard(name: "Main", bundle: nil)
    
    func createViewController<T: UIViewController>(by type: T.Type) -> T where T: ViewControllerReusable {
        
        guard let controller = main.instantiateViewController(withIdentifier: T.identifier) as? T else {
            
            fatalError("It was not possible to create the ViewController '\(T.identifier)' because the StoryboardID has a different identifier: '\(T.identifier)'.")
        }
        
        return controller
    }
}
