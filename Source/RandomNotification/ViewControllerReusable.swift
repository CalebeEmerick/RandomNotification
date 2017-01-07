//
//  ViewControllerReusable.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

public protocol ViewControllerReusable {
    
    static var identifier: String { get }
}

public extension ViewControllerReusable where Self : UIViewController {
    
    static var identifier: String {
        
        return String(describing: self)
    }
}

extension UIViewController : ViewControllerReusable { }
