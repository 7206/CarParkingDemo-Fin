//
//  PhoneverificationViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
var changeStatus = false
class PhoneVerifyVC: UIViewController {
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var phoneno: UITextField!
    @IBOutlet weak var verificationcode: UITextField!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var sucessview: UIView!
 
    @IBAction func sendbtn(_ sender: UIButton) {

        Auth.auth().sendPasswordReset(withEmail: phoneno.text!) { error in
            DispatchQueue.main.async {
                if self.phoneno.text?.isEmpty==true || error != nil {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                if error == nil && self.phoneno.text?.isEmpty==false{
                    let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
                    resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailAlertSent, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneno.setLeftPaddingPoints(10)
        verificationcode.setLeftPaddingPoints(10)
        self.hideKeyboardWhenTappedAround()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      //  sucessview.layer.cornerRadius = 45
    }
    @IBAction func submitbtn(_ sender: UIButton) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if  changeStatus == true {
            
            phoneLbl.text = "Email Verification"
            phoneno.placeholder = "Email"
        }
        else {
            phoneLbl.text = "Phone Verification"
            phoneno.placeholder = "Phone No"

        }
       
    }
    @IBAction func backbutton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        //For mobile numer validation
//        if textField == self.phoneno {
//            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
//            let characterSet = CharacterSet(charactersIn: string)
//            return allowedCharacters.isSuperset(of: characterSet)
//        }
//        return true
//    }
    func resetpassword() {
//        Auth.auth().sendPasswordReset(withEmail: phoneno.text!)
//        ActionCodeSettings:(FIRActionCodeSettings *)actionCodeSettings
//        completion:(nullable FIRSendPasswordResetCallback)completion;
      
    }
  
}


