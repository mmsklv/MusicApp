//
//  AppDelegate.swift
//  MusicApp
//
//  Created by MacBook on 03.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppConstants.deviceOrientation
    }


    func applicationWillTerminate(_ application: UIApplication) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "currentTime")
    }
}

