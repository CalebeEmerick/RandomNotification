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
    @IBAction private func cancelAction(_ sender: UIButton) { }
    @IBAction private func sendNotification(_ sender: UIButton) { }
}

extension NotificationView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notificationButtonStyle()
    }
}

extension NotificationView {
    
    fileprivate func notificationButtonStyle() {
        
        notificationButton.layer.cornerRadius = 5
        notificationButton.clipsToBounds = true
    }
}
