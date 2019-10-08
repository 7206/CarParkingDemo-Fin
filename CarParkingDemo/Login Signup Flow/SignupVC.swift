//
//  SignupViewController.swift
//  CarParkingDemo
//
//  Created by admin on 05/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import iOSDropDown

class SignupVC: UIViewController,UITextFieldDelegate {
   
 
    //var userlist = [Usernames]()
    var refName: DatabaseReference!

    // MARK:-----------Outlets--------------

    @IBOutlet weak var backbtnoulet: UIButton!
    @IBOutlet var mainview: UIView!
    @IBOutlet weak var dropdowntext: DropDown!
    
    @IBOutlet weak var phoneno: UITextField!
   
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verificationotp: UITextField!
    
    
    @IBOutlet weak var signupbtnoutlet: LoadingButton!

    // MARK:-----------Did Load-------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        backbtnoulet.contentVerticalAlignment = .fill
        backbtnoulet.contentHorizontalAlignment = .fill
        backbtnoulet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        username.setLeftPaddingPoints(10)
        dropdowntext.setLeftPaddingPoints(12)
        password.setLeftPaddingPoints(10)
       // phoneno.setLeftPaddingPoints(3)
        verificationotp.setLeftPaddingPoints(10)
        self.hideKeyboardWhenTappedAround()
       // phoneno.delegate = self
        verificationotp.delegate = self
        dropdowntext.optionArray = ["+1", "+2", "+3"]
    }
    
    
    // MARK:-----------BUTTON ACTIONS--------------
    
    @IBAction func back(_ sender: UIButton) {
     
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func login(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func Register(_ sender: UIButton) {
        
        if self.RagistationValidation()
        {
            self.signupbtnoutlet.showLoading()
            print("++++++++++++++++success)")
        Auth.auth().createUser(withEmail: username.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                self.saveuserinfo()
                
               // let abc = UserDefaults.standard.set(self.password.text!, forKey: "pass")

                
                self.signupbtnoutlet.showLoading()
                self.mainview.isUserInteractionEnabled = false
                print("You have successfully signed up")
                self.signupbtnoutlet.hideLoading()
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "CarManagementVC") as! CarManagementVC
                self.navigationController?.pushViewController(VC, animated: true)
                 self.signupbtnoutlet.hideLoading()
                self.mainview.isUserInteractionEnabled = true
            }}
        }
        
//        guard let verificationotp = verificationotp.text, let email = username.text, let password = password.text,
//            let phone = phoneno.text else {
//                return
//        }
//
//        let isValidateEmail = self.validation.validateEmailId(emailID: email)
//        if (isValidateEmail == false){
//            print("Incorrect Email")
//            return
//        }
//        let isValidatePhone = self.validation.validaPhoneNumber(phoneNumber: phone)
//        if (isValidatePhone == false) {
//            print("Incorrect Phone")
//            return
//        }
//        let isValidateName = self.validation.validateotp(name: verificationotp)
//        if (isValidateName == false) {
//            print("Incorrect Name")
//            return
//        }
//        let isValidatePass = self.validation.validatePassword(password: password)
//        if (isValidatePass == false) {
//            print("Incorrect Pass")
//            return
//        }
//
//        if (isValidateName == true || isValidateEmail == true || isValidatePass == true || isValidatePhone == true) {
//            Auth.auth().createUser(withEmail: username.text!, password: password.text!) { (user, error) in
//
//                            if error == nil {
//                                self.saveuserinfo()
//
//                                self.signupbtnoutlet.showLoading()
//                                print("You have successfully signed up")
//                                self.signupbtnoutlet.hideLoading()
//                                let VC = self.storyboard?.instantiateViewController(withIdentifier: "CarManagementVC") as! CarManagementVC
//                                self.navigationController?.pushViewController(VC, animated: true)
//
//                            }
//        }
        
        
        
        
        
//
//       // addName()
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
    func saveuserinfo(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        let user = Auth.auth().currentUser
        if let userinfo = user {
            let email = userinfo.email
        let userinfo = ["emailid":email]
        
        let values = [uid : userinfo]
        
        Database.database().reference().child("userinfo").updateChildValues(values, withCompletionBlock:{(err,reference) in
            if let err = err {
                print(err)
                return
            }
            print("Data saved on firebase")

            self.dismiss(animated: true, completion: nil)
        })
    }
}
    func RagistationValidation()->Bool
    {
    if username.text  == "" {
    self.displayAlertMessage(messageToDisplay: "Please enter email")
        return false
    }
    else  if (phoneno.text!.count == 0){
    self.displayAlertMessage(messageToDisplay: "Enter phone no.")
        return false
    }
    else if (verificationotp.text!.count == 0){
    self.displayAlertMessage(messageToDisplay: "Please enter otp")
        return false
    }
    else if password.text  == "" {
    self.displayAlertMessage(messageToDisplay: "Please enter password")
        return false
    }
    else {
    if self.username.text!.count < 10
    {
    self.displayAlertMessage(messageToDisplay: "Please enter valid emailid.")
        return false
    }
    else if self.phoneno.text!.count < 9
    {
    self.displayAlertMessage(messageToDisplay: "Please enter valid mobile no.")
        return false
    }
    else if(verificationotp.text!.count < 7)
    {
    self.displayAlertMessage(messageToDisplay: "Otp must be of 7 numbers")
        return false
    }
    else if(password.text!.count <= 10)
    {
    self.displayAlertMessage(messageToDisplay: "Please enter valid password")
        return false
    }
    else {
        return true

    //                else {
    //
    //                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
    //
    //                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    //                    alertController.addAction(defaultAction)
    //
    //                    self.present(alertController, animated: true, completion: nil)
    //                }
    }
    }
        
    
    }

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
        return false
    }
    let maxLength = 7
    let currentString: NSString = verificationotp?.text as! NSString
    let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
    return newString.length <= maxLength
    
}
}
