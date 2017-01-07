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
    
    weak var controller: UIViewController?
    private let content = UNMutableNotificationContent()
    private let viewPostAction = UNNotificationAction(identifier: NotificationIdentifier.viewPost, title: "Ver Publicação", options: [])
    private let dismissAction = UNNotificationAction(identifier: NotificationIdentifier.dismiss, title: "Descartar", options: [.destructive])
    private let delegate = NotificationDelegate()

    func show(from category: Category, with image: UIImage) {
        
        RFileManager.shared.save(image: image)
        let attachment = makeAttachment()
        let categoryAction = makeCategory()
        
        content.title = category.nameFormatted
        content.body = "Testing Rich Notifications with random images 😄"
        content.sound = .default()
        content.categoryIdentifier = NotificationIdentifier.category
        content.attachments = [attachment]
        
        makeRequest(with: content, action: categoryAction)
    }
    
    private func makeRequest(with content: UNMutableNotificationContent, action category: UNNotificationCategory) {
        
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request, content: content, trigger: nil)
        
        delegate.controller = controller
        UNUserNotificationCenter.current().delegate = delegate
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().add(request) { error in
            
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    private func makeAttachment() -> UNNotificationAttachment {
        
        let imageUrl = RFileManager.shared.retrieveImageUrl()
        guard let attachment = try? UNNotificationAttachment(identifier: NotificationIdentifier.request, url: imageUrl, options: [:]) else {
            
            fatalError("It was not possible to create an attachment.")
        }
        
        return attachment
    }
    
    private func makeCategory() -> UNNotificationCategory {
        
        let category = UNNotificationCategory(identifier: NotificationIdentifier.category, actions: [viewPostAction, dismissAction], intentIdentifiers: [], options: [])
        
        return category
    }
}
