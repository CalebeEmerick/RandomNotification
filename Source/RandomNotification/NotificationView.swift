//
//  NotificationView.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 19/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit

final class NotificationView : UIView {
    
    @IBOutlet fileprivate weak var categoryName: UILabel!
    @IBOutlet fileprivate weak var notificationButton: UIButton!
    @IBOutlet fileprivate weak var cancelButton: UIButton!
    @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
    @IBAction private func cancelAction(_ sender: UIButton) {
        stopLoadingIfNeeded()
        cancelDidTap?()
    }
    @IBAction private func sendNotification(_ sender: UIButton) {
        sendDidTap?()
    }
    
    fileprivate enum ButtonState { case loading, stopped }
    fileprivate var buttonState: ButtonState = .stopped
    var cancelDidTap: (() -> Void)?
    var sendDidTap: (() -> Void)?
    var category: Category? { didSet { updateCategoryName() } }
}

extension NotificationView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notificationButtonStyle()
        cancelButtonStyle()
    }
}

extension NotificationView {
    
    func showLoading() {
        
        DispatchQueue.main.async {
            self.notificationButton.isEnabled = false
            self.notificationButton.setTitle("", for: .disabled)
            self.activityIndicator.startAnimating()
            self.buttonState = .loading
        }
    }
    
    func stopLoading() {
        
        DispatchQueue.main.async {
            self.notificationButton.isEnabled = true
            self.notificationButton.setTitle("Enviar Notificação", for: .normal)
            self.activityIndicator.stopAnimating()
            self.buttonState = .stopped
        }
    }
    
    fileprivate func updateCategoryName() {
        
        guard let category = category else { return }
        
        self.animateNameChange(category.nameFormatted)
    }
    
    fileprivate func notificationButtonStyle() {
        
        notificationButton.layer.cornerRadius = 5
        notificationButton.clipsToBounds = true
    }
    
    fileprivate func cancelButtonStyle() {
        
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = Color(hexString: "#DE352E").cgColor
        cancelButton.layer.cornerRadius = 5
        cancelButton.clipsToBounds = true
    }
    
    fileprivate func stopLoadingIfNeeded() {
        
        guard buttonState == .loading else { return }
        
        stopLoading()
    }
    
    private func animateNameChange(_ name: String) {
        
        animate(name: name)
    }

    private func animate(name: String) {
        
        let animation = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = 0.25
        
        categoryName.layer.add(animation, forKey: nil)
        categoryName.text = name
    }
}
