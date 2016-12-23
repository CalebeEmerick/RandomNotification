//
//  HomeView.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

protocol HomeView : class {
    
    func showNotification(from category: Category, with image: UIImage)
    func lockUI()
    func showLoading()
    func hideLoading()
}
