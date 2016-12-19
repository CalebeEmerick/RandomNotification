//
//  HomeController.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

// MARK: - Variables & Outlets -

final class HomeController : UIViewController {
    
    @IBOutlet fileprivate weak var isGraySwitch: UISwitch!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var separatorHeight: NSLayoutConstraint!
    
    fileprivate let dataSource = HomeDataSource()
    fileprivate let delegate = HomeDelegate()
    fileprivate let notificationView = NotificationView.makeXib()
}

// MARK: - Life Cycle -

extension HomeController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
        setupTableView()
    }
}

// MARK: - Methods -

extension HomeController {
    
    fileprivate func setupController() {
        
        separatorHeight.constant = 0.5
    }
    
    fileprivate func setupTableView() {
        
        tableView.register(cellNib: CategoryCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 60
    }
}
