//
//  UserInfoViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase

var refName: DatabaseReference!

class UserProfileInfoVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var submitbtnoutlet: UIButton!
    
    @IBAction func submitbtn(_ sender: UIButton) {
        saveuserinfo()
    }
   
  
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var Phoneno: UITextField! 
    
    @IBOutlet weak var emaillable: UILabel!
    
    @IBOutlet weak var phonelable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            displayfirebasedata()
         Phoneno.delegate = self
        self.hideKeyboardWhenTappedAround()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
//    override func viewWillAppear(_ animated: Bool) {
//        submitupdate()
//
//    }
//    func currentuser(){
//        let user = Auth.auth().currentUser
//        if let userinfo = user {
//            let email = userinfo.email
//            self.emaillable.text = email
//            self.Email.text = emaillable.text
//        }
//    }
//    func submitupdate(){
//        if self.Email.text?.count == 0,self.Phoneno.text?.count == 0,self.Name.text?.count == 0 {
//            self.submitbtnoutlet.setTitle("Submit", for: .normal)
//        }
//        else {
//            self.submitbtnoutlet.setTitle("Update", for: .normal)
//        }
//    }
    func saveuserinfo(){
        guard let uid = Auth.auth().currentUser?.uid else{return}
            let userinfo = ["emailid":self.Email.text as! String,"Username":self.Name.text as! String,"Phone no":self.Phoneno.text as! String]
            
            
            let values = [uid : userinfo]
            
            Database.database().reference().child("userinfo").updateChildValues(values, withCompletionBlock:{(err,reference) in
                if let err = err {
                    print(err)
                    return
                }
                print("Data saved on firebase")
                self.emaillable.text = self.Email.text
                self.phonelable.text = self.Phoneno.text
                self.dismiss(animated: true, completion: nil)
            })
        }
    
    func displayfirebasedata(){
         guard let uid = Auth.auth().currentUser?.uid else{return}
        refName = Database.database().reference().child("userinfo").child(uid)
        refName.observeSingleEvent(of: .value, with: {(snapshot) in
 
        let userObject = snapshot.value as? [String: AnyObject]
            let email =   userObject?["emailid"]
            let phone = userObject?["Phone no"]
            let username = userObject?["Username"]
            
            self.emaillable.text = email as? String
            self.Phoneno.text = phone as? String
            self.Name.text = username as? String
            self.Email.text = self.emaillable.text
            self.phonelable.text = self.Phoneno.text
        })}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == self.Phoneno {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }

}
