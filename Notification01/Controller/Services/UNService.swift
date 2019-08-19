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
        
        setupAction()
    }
    
    func setupAction() {
        // Action for Timer notification
        
        let timerAction =  UNNotificationAction(identifier: NotificationActions.timer.rawValue,
                                                title: "Timer action here",
                                                options: [.authenticationRequired])
        
        let timerCategory = UNNotificationCategory(identifier: NotificationCategories.timer.rawValue,
                                                   actions: [timerAction],
                                                   intentIdentifiers: [])
        
        // Action for Date notification
        
        let dateAction =  UNNotificationAction(identifier: NotificationActions.date.rawValue,
                                               title: "Date action here",
                                               options: [.destructive])
        
        let dateCategory = UNNotificationCategory(identifier: NotificationCategories.date.rawValue,
                                                  actions: [dateAction],
                                                  intentIdentifiers: [])
        
        // Action for Location notification
        
        let locationAction =  UNNotificationAction(identifier: NotificationActions.location.rawValue,
                                                   title: "Location action here",
                                                   options: [.foreground])
        
        let locationCategory = UNNotificationCategory(identifier: NotificationCategories.location.rawValue,
                                                      actions: [locationAction],
                                                      intentIdentifiers: [])
        
        unCenter.setNotificationCategories([timerCategory, dateCategory, locationCategory])
    }
    
    func getImage(for type: NotificationImages) -> UNNotificationAttachment? {
        var imageName: String
        
        switch type {
        case .timer: imageName = "TimerAlert"
        case .date: imageName = "DateAlert"
        case .location: imageName = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
        
        do {
            let image = try UNNotificationAttachment(identifier: type.rawValue, url: url)
            
            return image
        } catch {
            return nil
        }
    }
    
    func requestTimer(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        
        content.title = "Timer Yay!"
        content.body  = "Your timer notification is all done."
        content.sound = .default
        content.badge = 99
        
        if let attachment = getImage(for: .timer) {
            content.attachments = [attachment]
        }
        
        content.categoryIdentifier = NotificationCategories.timer.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "UN.timer", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func requestDate(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        
        content.title = "Date Wohoo!"
        content.body  = "We are in the future now."
        
        if let attachment = getImage(for: .date) {
            content.attachments = [attachment]
        }
        
        content.categoryIdentifier = NotificationCategories.date.rawValue
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: "UN.date", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func requestLocation() {
        let content = UNMutableNotificationContent()
        
        content.title = "Location Wkwk!"
        content.body  = "Welcome back."
        
        if let attachment = getImage(for: .location) {
            content.attachments = [attachment]
        }
        
        content.categoryIdentifier = NotificationCategories.location.rawValue
        
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("User Notification will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        
        completionHandler(options)
    }
}
