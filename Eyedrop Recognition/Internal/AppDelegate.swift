
//  Created by Ludovico Veniani on 5/1/21.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//


import UIKit
import AVFoundation


@UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("Device token: \(deviceTokenString)")
        
        UserDefaults.standard.set(deviceTokenString, forKey: "registrationID")
    }
    
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
   
        
        

    
}
