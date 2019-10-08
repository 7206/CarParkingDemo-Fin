//
//  ChangePasswordViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
class ChangePasswordVC: UIViewController {

    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBAction func backbtn(_ sender: UIButton) {
      
        self.navigationController?.popViewController(animated: true)

    }
    @IBOutlet weak var currentpassword: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @IBAction func submitbtn(_ sender: UIButton) {
        if (currentpassword.text!.count == 0){
            self.displayAlertMessage(messageToDisplay: "Enter current password.")
        }
        if (newpassword.text!.count == 0){
            self.displayAlertMessage(messageToDisplay: "Enter new password.")
        }
        else if(newpassword.text!.count<7 || newpassword.text!.count>12) {
            self.displayAlertMessage(messageToDisplay: "Password length should be between 7 to 12 characters.")
        }
        else {
            if (confirmpassword.text!.count == 0){
                self.displayAlertMessage(messageToDisplay: "Enter confirm password")
            }
            if(newpassword.text! != confirmpassword.text!  ) {
                self.displayAlertMessage(messageToDisplay: "Password do not match.")
            }
            else {
               authenticateUser()
               // self.displayAlertMessage(messageToDisplay: "Success")
            }
        }
        }
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    func authenticateUser()
    {
        let user = Auth.auth().currentUser
        let updatedPassword = self.newpassword.text
        user?.updatePassword(to: updatedPassword!, completion: {  error in
            if error != nil {
                self.displayAlertMessage(messageToDisplay: "Error")
            } else {
                self.displayAlertMessage(messageToDisplay: "Password changed")
            }
        })
}
}
