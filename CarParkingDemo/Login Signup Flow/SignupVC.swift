//
//  SignupViewController.swift
//  CarParkingDemo
//
//  Created by admin on 05/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
import CountryPickerView


class SignupVC: UIViewController,UITextFieldDelegate,CountryPickerViewDelegate, CountryPickerViewDataSource  {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        countrylbl.text = countryPickerView.selectedCountry.phoneCode
    }

    //var userlist = [Usernames]()
    var refName: DatabaseReference!


    // MARK:-----------Outlets--------------
let countryPickerView = CountryPickerView()
    @IBAction func dropbtn(_ sender: Any) {
         countryPickerView.showCountriesList(from: self)
    }
    
 
    @IBAction func verify(_ sender: Any) {
        guard let otp = self.verificationotp.text else {return}
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {return}
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID,verificationCode: otp)
        
        Auth.auth().signIn(with: credential) { (sucess, error) in
            if  error == nil {
                print(sucess)
                print("user is signed")
                
            }
            else {
                print("something went wrong\(error?.localizedDescription)" )
            }
        }
    }
    @IBAction func newbtn(_ sender: Any) {
         Auth.auth().languageCode = "en";
        guard let phonenumber = self.phoneno.text else {return}
//        let alert = UIAlertController(title: "Phone number", message: "Is this your phone number? \n \(phoneno.text!)", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            PhoneAuthProvider.provider().verifyPhoneNumber(phonenumber, uiDelegate: nil) { (verificationID, error) in
                if error == nil {
                    print(verificationID)
                   // guard let verifyid = verificationID else {return}
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    //UserDefaults.synchronize()
                }
                else {
                    print("unable to get secret key",error?.localizedDescription)
                }
            }
//
//        let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
//        alert.addAction(action)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var dropdownoutlet: UIButton!
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var backbtnoulet: UIButton!
    @IBOutlet var mainview: UIView!
   
    
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
        password.setLeftPaddingPoints(10)
       // phoneno.setLeftPaddingPoints(3)
        verificationotp.setLeftPaddingPoints(10)
        self.hideKeyboardWhenTappedAround()
       // phoneno.delegate = self
        verificationotp.delegate = self
        countryPickerView.delegate = self
        countryPickerView.dataSource = self

        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print("country code is \(countryCode)")
            countrylbl.text! = getCountryCallingCode(countryRegionCode: countryCode)
         
        }
        
        
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
        
        Auth.auth().createUser(withEmail: username.text!, password: password.text!) { (user, error) in
            
            if error == nil {
                self.saveuserinfo()
                
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
    func getCountryCallingCode(countryRegionCode:String)->String{
        
        let prefixCodes = ["AF": "+93", "AE": "+971", "AL": "+355", "AN": "+599", "AS":"+1", "AD": "376", "AO": "244", "AI": "+1", "AG":"+1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "+1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "+1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "+1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "+1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "+1", "GT": "502", "GN":"224","GW": "+245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "+36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "+91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"+1", "LC": "+1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryRegionCode]
        return countryDialingCode!
        
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
//    else if (verificationotp.text!.count == 0){
//    self.displayAlertMessage(messageToDisplay: "Please enter otp")
//        return false
//    }
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
    else if(verificationotp.text!.count < 6)
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
    }
    }
        
    
    }

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
        return false
    }
    let maxLength = 6
    let currentString: NSString = verificationotp?.text as! NSString
    let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
    return newString.length <= maxLength
    
}
}
