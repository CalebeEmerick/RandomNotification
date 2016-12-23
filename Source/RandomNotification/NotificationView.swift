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
    @IBAction private func cancelAction(_ sender: UIButton) { cancelDidTap?() }
    @IBAction private func sendNotification(_ sender: UIButton) { sendDidTap?() }
    
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
    
    fileprivate func updateCategoryName() {
        
        guard let category = category else { return }
        
        self.animateNameChange(category.name)
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
