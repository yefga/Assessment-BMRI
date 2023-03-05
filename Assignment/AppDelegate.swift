//
//  AppDelegate.swift
//  Assignment
//
//  Created by yepz on 04/03/23.
//

import UIKit
import netfox

@main
class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        NFX.sharedInstance().start()
        NFX.sharedInstance().setGesture(.shake)
        
        let vc = ListRouter().createModule()
        window?.rootViewController = UINavigationController(rootViewController: vc)

        window?.makeKeyAndVisible()
        
        return true
    }
    
    


}

