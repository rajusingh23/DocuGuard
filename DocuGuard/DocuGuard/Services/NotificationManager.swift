//
//  NotificationManager.swift
//  DocuGuard
//
//  Created by Raju Singh on 22/06/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
        
    }
    
    func sendDeleteNotification(with name: String) {
        let content = UNMutableNotificationContent()
        content.title = "Item Deleted"
        content.body = "\(name) was deleted"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Local notification scheduled for \(name)")
            }
        }
    }
}
