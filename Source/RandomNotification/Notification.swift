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
    
    private weak var controller: UNUserNotificationCenterDelegate?
    private let delegate = NotificationDelegate()
    
    init(controller: UNUserNotificationCenterDelegate?) {
        self.controller = controller
    }
    
    func show() {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Random N."
        content.subtitle = "Teste de notificação"
        content.body = "blá blá blá blá blá blá..."
        content.sound = .default()

        makeRequest(with: content)
    }
    
    private func makeRequest(with content: UNMutableNotificationContent) {
        
        let request = UNNotificationRequest(identifier: NotificationIdentifier.request, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().delegate = controller
        UNUserNotificationCenter.current().add(request) { error in
            
            if let error = error { print(error.localizedDescription) }
        }
    }
    
    private func makeUrl(from image: UIImage?) -> URL {
        
//        guard let path = Bundle.main.path(forResource: "", ofType: <#T##String?#>)
        
//        if let path = Bundle.main.path(forResource: "monkey", ofType: "png") {
//            let url = URL(fileURLWithPath: path)
//            
//            do {
//                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
//                content.attachments = [attachment]
//            } catch {
//                print("attachment not found.")
//            }
//        }
        
        return URL(string: "")!
    }
}

//        guard let attachment = try? UNNotificationAttachment(identifier: "", url: <#T##URL#>, options: [:]) else { return }
