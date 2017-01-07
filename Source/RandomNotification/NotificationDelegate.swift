//
//  NotificationDelegate.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 23/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit
import UserNotifications

final class NotificationDelegate : NSObject {
    
    weak var controller: UIViewController?
    fileprivate var directoryUrl: URL?
    
    deinit {
        directoryUrl?.stopAccessingSecurityScopedResource()
    }
}

extension NotificationDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {

        guard response.actionIdentifier != NotificationIdentifier.dismiss else {
            completionHandler()
            return
        }

        guard let attachment = response.notification.request.content.attachments.first else { return }
        guard attachment.url.startAccessingSecurityScopedResource() else { return }
        
        let router = HomeRouter(pass: controller)
        let image = RFileManager.shared.currentImage

        router.showDetail(with: image)
        completionHandler()
    }
}
