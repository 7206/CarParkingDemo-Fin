//
//  NavigationViewController.swift
//  CarParkingDemo
//
//  Created by admin on 25/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
setRootViewController()
        // Do any additional setup after loading the view.
    }
    
    func setRootViewController() {
        if Auth.auth().currentUser != nil {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "CarManagementVC") as! CarManagementVC
            self.navigationController?.pushViewController(VC, animated: true)
            // Set Your home view controller Here as root View Controller
            //self.presentTabBar()
        } else {
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as! StartVC
            self.navigationController?.pushViewController(VC, animated: true)
            // Set you login view controller here as root view controller
        }
    }
    

    class ReplaceSegue: UIStoryboardSegue {
        
        override func perform() {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newRootView = storyBoard.instantiateViewController(withIdentifier: "CarManagementVC") as! CarManagementVC
            source.navigationController?.setViewControllers([newRootView], animated: true)
        }
    }
}
