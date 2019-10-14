//
//  AppDelegate.swift
//  CarParkingDemo
//
//  Created by admin on 05/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import IQKeyboardManagerSwift
import Braintree
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var databaseRef: DatabaseReference!
   
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth
       Auth.auth().setAPNSToken(deviceToken, type: .prod)

    }
 
//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification notification: [AnyHashable : Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if Auth.auth().canHandleNotification(notification) {
//            completionHandler(.noData)
//            return
//        }
//        // This notification is not auth related, developer should handle it.
//        handleNotification(notification)
//    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        BTAppSwitch.setReturnURLScheme("com.CarParkingDemo.payments")
        Stripe.setDefaultPublishableKey("pk_test_UKxhpD4nBIwmGSSIos2Njpi300aBAXBwov")
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
    //MARK: - Activity Indicator -
}
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    if url.scheme?.localizedCaseInsensitiveCompare("com.CarParkingDemo.payments") == .orderedSame {
        return BTAppSwitch.handleOpen(url, sourceApplication: sourceApplication)
    }
    return false
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }}
extension UIView {
    
    func designable() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
      //  self.layer.borderWidth = 1
    
    //    self.layer.backgroundColor = UIColor.white.cgColor
    }}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showAlertView(title:String,msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}
