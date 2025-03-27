//
//  AppDelegate.swift
//  AnalyticsDemo
//

import UIKit
import AnalyticsKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // setup analytics
        let config = AnalyticsConfig(accountId: "your_account_id", devToken: "your_dev_token")
        Analytics.setup(config: config)
        // add custom params
        Analytics.addCustomParams(["custom_data": "custom_value"])
        // create data sender
        let dataSender = MyDataSender()
        // setup store path
        let doc = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = "\(doc)/app.db"
        print("path: \(path)")
        // create data store
        let dataStore = try! DefaultDataStore(path: path)
        // register data service
        let dataService = DefaultDataService(dataStore: dataStore, dataSender: dataSender)
        Analytics.register(service: dataService)
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

