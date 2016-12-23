//
//  HomeView.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

protocol HomeView : class {
    
    func lockUI()
    func unlockUI()
    func showLoading()
    func hideLoading()
    func showNotification(from category: Category, with image: UIImage)
    func showAlert(with message: String)
}
