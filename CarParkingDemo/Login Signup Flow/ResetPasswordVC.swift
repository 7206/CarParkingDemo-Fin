//
//  ResetPasswordViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var enterpassword: UITextField!
    @IBOutlet weak var reenterpassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterpassword.setLeftPaddingPoints(10)
        reenterpassword.setLeftPaddingPoints(10)
        self.hideKeyboardWhenTappedAround()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @IBAction func backbtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func nextbtn(_ sender: UIButton) {
        if (enterpassword.text!.count == 0){
            self.displayAlertMessage(messageToDisplay: "Enter the password.")
        }
        else if(enterpassword.text!.count<7 || enterpassword.text!.count>12) {
            self.displayAlertMessage(messageToDisplay: "Password length should be between 7 to 12 characters.")
        }
        else {
            if (reenterpassword.text!.count == 0){
                self.displayAlertMessage(messageToDisplay: "Re-enter the password")
            }
             if(enterpassword.text! != reenterpassword.text!  ) {
                self.displayAlertMessage(messageToDisplay: "Password do not match.")
            }
            else {
                self.displayAlertMessage(messageToDisplay: "Success")
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
}
