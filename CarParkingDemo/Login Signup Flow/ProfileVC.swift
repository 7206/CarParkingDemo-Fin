//
//  ProfileViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var accountview: UIView!
    @IBOutlet weak var helpview: UIView!
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var FAQbtnoutlet: UIButton!
    
    // MARK:-----------Did Load--------------

    override func viewDidLoad() {
        super.viewDidLoad()
        accountview.designable()
        helpview.designable()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    // MARK:-----------Button Actions--------------
    
    @IBAction func userinfo(_ sender: UIButton) {
   
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileInfoVC") as! UserProfileInfoVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func carmanagement(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "CarManagementVC") as! CarManagementVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func changepassword(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func paymentmethod(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func FAQ(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "FAQVC") as! FAQVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func Helpline(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "HelplineVC") as! HelplineVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func goback(_ sender: Any) {
        showloader = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signout(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()

                let VC = self.storyboard?.instantiateViewController(withIdentifier: "StartVC") as! StartVC
                self.navigationController?.pushViewController(VC, animated: true)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    


}
