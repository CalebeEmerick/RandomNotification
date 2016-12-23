//
//  HomeController.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit
import UserNotifications

// MARK: - Variables & Outlets -

final class HomeController : UIViewController {
    
    @IBOutlet fileprivate weak var isGraySwitch: UISwitch!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var separatorHeight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    fileprivate let dataSource = HomeDataSource()
    fileprivate let delegate = HomeDelegate()
    fileprivate let notificationView = NotificationView.makeXib()
    fileprivate var category: Category?
    fileprivate var presenter: HomePresenter?
    fileprivate var notification: Notification?
    fileprivate var bottomConstraint: NSLayoutConstraint!
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
        notification = Notification(controller: self)
        presenter = HomePresenter(view: self)
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
            NotificationPermission.shared.requestPermission { [weak self] success in
                self?.shouldShowNotification(with: success)
            }
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
    
    private func showAlertToAllowNotification() {
        
        let alert = UIAlertController(title: "Notificação", message: "Você não permitiu notificações 😕. Deseja habilitar agora?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { _ in }
        let allow = UIAlertAction(title: "Habilitar Agora", style: .default) { _ in
            NotificationPermission.shared.openAppSettings() }
        
        alert.addAction(cancel)
        alert.addAction(allow)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func shouldShowNotification(with success: Bool) {
        
        if success {
            
            guard let category = self.category else { return }
            let isGrayScale = isGraySwitch.isOn
            self.presenter?.showNotification(from: category, isGrayScale: isGrayScale)
        }
        else {
            self.showAlertToAllowNotification()
        }
    }
}

extension HomeController : HomeView {
    
    func showNotification(from category: Category, with image: UIImage) {
        
        notification?.show(from: category, with: image)
    }
    
    func lockUI() {
        
        tableView.allowsSelection = false
        isGraySwitch.isUserInteractionEnabled = false
    }
    
    func showLoading() {
        
        notificationView.showLoading()
    }
    
    func hideLoading() {
        
        notificationView.stopLoading()
    }
}

extension HomeController : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
}
