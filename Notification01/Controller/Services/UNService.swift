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
    
    func requestTimer(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        
        content.title = "Timer Yay!"
        content.body  = "Your timer notification is all done."
        content.sound = .default
        content.badge = 99
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "UN.timer", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func requestDate(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        
        content.title = "Date Wohoo!"
        content.body  = "We are in the future now."
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "UN.date", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func requestLocation() {
        let content = UNMutableNotificationContent()
        
        content.title = "Location Wkwk!"
        content.body  = "Welcome back."
        
        let request = UNNotificationRequest(identifier: "UN.location", content: content, trigger: nil)
        
        unCenter.add(request)
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
