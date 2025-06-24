//
//  DocuGuardApp.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI
import Firebase
import GoogleSignIn
import UserNotifications

@main
struct DocuGuardApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .onAppear {
                    NotificationManager.shared.requestPermission()
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping
                                (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
