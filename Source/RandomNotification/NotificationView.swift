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
