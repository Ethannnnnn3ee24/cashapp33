//
//  AppDelegate.swift
//  Cache
//
//  Created by Jeffrey Santana on 2/10/18.
//  Copyright © 2018 Jefffrey Santana. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		
		window = UIWindow(frame: UIScreen.main.bounds)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		var rootVC: UIViewController!
		Auth.auth().addStateDidChangeListener { (auth, user) in
			if user != nil {
				rootVC = storyboard.instantiateViewController(withIdentifier: "MainNavController")
				print("A USER IS LOGGED IN")
			} else {
				rootVC = storyboard.instantiateViewController(withIdentifier: "LoginNavController")
				print("USER MUST LOG IN")
			}
			
			self.window?.rootViewController = rootVC
			self.window?.makeKeyAndVisible()
		}
		
//		UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
//			application.registerForRemoteNotifications()
//		}
//		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

