//
//  AppDelegate.swift
//  Todoey
//
//  Created by User on 11/11/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        do{
        _ = try Realm()
        }catch{
            print("error initializing new realm,  \(error)")
        }
        
        return true
    }
}
