//
//  NotificationPermission.swift
//  RandomNotification
//
//  Created by Calebe Emerick on 20/12/16.
//  Copyright © 2016 CalebeEmerick. All rights reserved.
//

import UIKit
import UserNotifications

final class NotificationPermission {
    
    private init() { }
    static let shared = NotificationPermission()
}

extension NotificationPermission {
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        
        checkAuthorizationStatus { result in completion(result) }
    }
    
    func openAppSettings() {
        
        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func checkAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        
        UNUserNotificationCenter.current().getNotificationSettings { [unowned self] settings in
            
            switch settings.authorizationStatus {
                
            case .authorized:
                completion(true)
            case .denied:
                completion(false)
            case .notDetermined:
                self.tryRequest { result in completion(result) }
            }
        }
    }
    
    private func tryRequest(completion: @escaping (Bool) -> Void) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            guard granted else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}
