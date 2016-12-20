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
    @IBOutlet fileprivate weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    fileprivate let dataSource = HomeDataSource()
    fileprivate let delegate = HomeDelegate()
    fileprivate let notificationView = NotificationView.makeXib()
    fileprivate var bottomConstraint: NSLayoutConstraint!
    fileprivate var category: Category?
    fileprivate var lastIndexPathSelected: IndexPath?
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
        
        makeConstrainsForNotificationView()
        setShadowForNotificationView()
        setupCallbacks()
        separatorHeight.constant = 0.5
    }
    
    fileprivate func setupTableView() {
        
        tableView.register(cellNib: CategoryCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 60
    }
    
    private func setupCallbacks() {
        
        delegate.categorySelected = { [unowned self] (category, indexPath) in
            self.category = category
            self.lastIndexPathSelected = indexPath
            self.setNotificationView(with: category)
        }
        notificationView.cancelDidTap = {
            self.deselectItem()
            self.hideNotificationView()
        }
        notificationView.sendDidTap = {
            
        }
    }
    
    private func setNotificationView(with category: Category) {
        
        self.notificationView.category = category
        self.showNotificationViewIfNeeded()
    }
    
    private func makeConstrainsForNotificationView() {
        
        self.view.addSubview(notificationView)
        bottomConstraint = NSLayoutConstraint(item: notificationView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: notificationView.bounds.height)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        notificationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        notificationView.heightAnchor.constraint(equalToConstant: notificationView.bounds.height).isActive = true
        self.view.addConstraint(bottomConstraint)
    }
    
    private func setShadowForNotificationView() {
        
        notificationView.layer.shadowOpacity = 0.5
        notificationView.layer.shadowColor = Color(hexString: "#aaa").cgColor
        notificationView.layer.shadowOffset = CGSize(width: 0, height: -5)
    }
    
    private func showNotificationViewIfNeeded() {
        
        guard bottomConstraint.constant != 0 else { return }
        
        showHideNotificationView(with: 0)
    }
    
    private func hideNotificationView() {
        
        showHideNotificationView(with: notificationView.bounds.height)
    }
    
    private func showHideNotificationView(with height: CGFloat) {
        
        bottomConstraint.constant = height
        tableViewBottomConstraint.constant = height == 0 ? notificationView.bounds.height : 0
        UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
    }
    
    private func deselectItem() {
        
        guard let indexPath = lastIndexPathSelected else { return }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
