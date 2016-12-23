//
//  Notification.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 21/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit
import UserNotifications

final class Notification : NSObject {
    
    private let content = UNMutableNotificationContent()
    private let delegate = NotificationDelegate()

    func show(from category: Category, with image: UIImage) {
        
        RFileManager.shared.save(image: image)
        content.title = category.nameFormatted
        content.body = "Testing Rich Notifications with random images 😄"
        content.sound = .default()
        
        let imageUrl = RFileManager.shared.retrieveImageUrl()
        guard let attachment = try? UNNotificationAttachment(identifier: NotificationIdentifier.request, url: imageUrl, options: [:]) else { return }
        
        content.attachments = [attachment]
        
        makeRequest(with: content)
    }
    
    private func makeRequest(with content: UNMutableNotificationContent) {
        
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().delegate = delegate
        UNUserNotificationCenter.current().add(request) { error in
            
            if let error = error { print(error.localizedDescription) }
        }
    }
}
