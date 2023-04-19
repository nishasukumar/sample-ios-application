//
//  AppDelegate.swift
//  rum-demo
//
//  Created by Adam Kaczmarek on 1/11/21.
//

import UIKit
import Foundation
import Datadog

/// A global instance of `URLSession` (think: Apple's HTTP Client)
internal fileprivate(set) var urlSession: URLSession!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appID = "e892992d-8143-41ca-a3f1-06e5ea2b15b1"
        let clientToken = "pub8a717a60acaad4ff5b02a61bd0c7773b"
        let environment = "dev"

        Datadog.initialize(
            appContext: .init(),
            trackingConsent: .granted,
            configuration: Datadog.Configuration
                .builderUsing(
                    rumApplicationID: appID,
                    clientToken: clientToken,
                    environment: environment
                )
                .set(endpoint: .us1)
                .trackUIKitRUMViews()
                .trackUIKitRUMActions()
                .trackRUMLongTasks()
                .build()
        )
            
        Global.rum = RUMMonitor.initialize()
        
        // Set up URLSession:
            urlSession = URLSession(
                configuration: .default,
                delegate: nil,
                delegateQueue: nil
            )
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
} 
