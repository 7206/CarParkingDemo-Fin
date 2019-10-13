//
//  LoginViewController.swift
//  CarParkingDemo
//
//  Created by admin on 05/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {

    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBtnOutlet: LoadingButton!
    
    @IBOutlet var mainview: UIView!
    // @IBOutlet weak var Dropdown: DropDown!
    
   
    // MARK:-----------Did Load--------------

    override func viewDidLoad() {
        super.viewDidLoad()
        username.setLeftPaddingPoints(10)
        password.setLeftPaddingPoints(10)
        self.hideKeyboardWhenTappedAround()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       
        
    }
    
    // MARK:-----------Button Actions--------------

    @IBAction func forgotpassword(_ sender: UIButton) {
   
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        self.navigationController?.pushViewController(VC, animated: true)
  
    }
    @IBAction func loginbtn(_ sender: UIButton) {
        loginbtn()
    }
    override func viewDidDisappear(_ animated: Bool) {
      // loginBtnOutlet.hideLoading()
    }
  
    @IBAction func back(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartVC")
//        self.present(vc!, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func QRCodeBtn(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
        self.navigationController?.pushViewController(VC, animated: true)

    }
    
    @IBAction func userProfileBtn(_ sender: Any) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    func loginbtn(){
        if self.username.text == "" || self.password.text == "" {

            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        
        } else {
              self.loginBtnOutlet.showLoading()
          //   self.mainview.isUserInteractionEnabled = false
            Auth.auth().signIn(withEmail: self.username.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
           
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    
                    
//                    //Go to the HomeViewController if the login is sucessful
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "navigation")
//                    self.present(vc!, animated: true, completion: nil)
                   
                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "CarManagementVC") as! CarManagementVC
                    self.navigationController?.pushViewController(VC, animated: true)
                   
            
                    
                } else {
                      self.loginBtnOutlet.hideLoading()
                   // self.mainview.isUserInteractionEnabled = false
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

}
