//
//  ForgotViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ForgetPasswordVC: UIViewController {
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var phonebtnOutlet: UIButton!
    
    @IBOutlet weak var emailbtnOutlet: UIButton!
    @IBAction func backbtn(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func phone(_ sender: UIButton) {
        changeStatus = false
        
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PhoneVerifyVC") as! PhoneVerifyVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func email(_ sender: UIButton) {
        
        changeStatus = true

        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PhoneVerifyVC") as! PhoneVerifyVC
        
//        if  changeStatus == true {
//            
//            VC.phoneLbl.text = "ajay"
//        }
//        else {
//            VC.phoneLbl.text = "Sachin"
//        }
        
        
        
        
        self.navigationController?.pushViewController(VC, animated: true)
        
//         let phone = self.storyboard?.instantiateViewController(withIdentifier:"PhoneVerifyVC") as! PhoneVerifyVC
//
//        changestatus = "asdada"
//        phone.phoneno.placeholder = "Email"
//        phone.phoneLbl.text = "Phone Verify"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }


}
