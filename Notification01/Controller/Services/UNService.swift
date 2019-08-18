//
//  UNService.swift
//  Notification01
//
//  Created by R. Kukuh on 13/08/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject {
    
    private override init() {}
    
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No User Notification error")
            
            guard granted else {
                print("User has denied User Notification access")
                return
            }
            
            self.configure()
        }
    }
    
    func configure() {
        unCenter.delegate = self
    }
    
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Notification received response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Notification will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        
        completionHandler(options)
    }
}
