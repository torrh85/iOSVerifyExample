//
//  AppDelegate.swift
//  iOSVerifyExample
//
//  Created by Hawer on 4/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let viewModel = LoginViewModel()
        
        let loginViewController = LoginViewController(viewModel: viewModel)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

