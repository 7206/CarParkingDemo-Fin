//
//  AddnewcarViewController.swift
//  CarParkingDemo
//
//  Created by admin on 11/09/19.
//  Copyright © 2019 admin. All rights reserved.


import UIKit
import Firebase
import MobileCoreServices
import SDWebImage

var showloader = false
class AddNewCarVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBOutlet weak var mainview: UIView!
    var indicator = UIActivityIndicatorView()
// MARK:-----------Variables--------------
    var carlist = [CarDetails]()
    
    
    var refName: DatabaseReference!
    var Serialno:String!
    var Engionno:String!
    var Carname:String!
    var Carimage:UIImage!

    // MARK:-----------Outlets--------------

    @IBOutlet weak var serialno: UITextField!
    @IBOutlet weak var engionno: UITextField!
    @IBOutlet weak var carname: UITextField!
    @IBOutlet weak var carimage: UIImageView!
    
    @IBOutlet weak var addCarButtonOutlet: LoadingButton!


    // MARK:-----------Didload--------------

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.refName = Database.database().reference()
 
        serialno.text = Serialno
        engionno.text = Engionno
        carname.text =  Carname
        carimage.image = Carimage
        self.hideKeyboardWhenTappedAround()
       // activityIndicator()
        self.serialno.setLeftPaddingPoints(10)
        self.engionno.setLeftPaddingPoints(10)
        self.carname.setLeftPaddingPoints(10)
    }
  
    
    // MARK:-----------Button Actions--------------

    
   @IBAction func Addnewcar(_ sender: UIButton) {
        if self.Serialno == nil{
            savefirebasedata()
        }
        else {
            self.updateData()
        }
    }
    
    @IBAction func backbtn(_ sender: UIButton) {
        showloader = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addimagebycamera(_ sender: UIButton) {
        let profileImagePicker = UIImagePickerController()
        profileImagePicker.allowsEditing = false
        profileImagePicker.sourceType = UIImagePickerController.SourceType.camera
        profileImagePicker.cameraCaptureMode = .photo
        profileImagePicker.modalPresentationStyle = .fullScreen
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true, completion: nil)
    }
    @IBAction func addimagebylibrary(_ sender: Any) {
        let profileImagePicker = UIImagePickerController()
        profileImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        profileImagePicker.mediaTypes = [kUTTypeImage as String]
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true, completion: nil)
    }
    
    
    
// MARK:========Firebase============
    func savefirebasedata(){
        if (serialno.text!.count == 0){
            self.displayAlertMessage(messageToDisplay: "Enter serial no")
        }
       else if (engionno.text!.count == 0){
            self.displayAlertMessage(messageToDisplay: "Enter engion no")
        }
        else if (carname.text!.count == 0){
            self.displayAlertMessage(messageToDisplay: "Enter carname")
        }
        else if (carimage.image == nil){
            self.displayAlertMessage(messageToDisplay: "Add image")
        }
        else{
            addCarButtonOutlet.showLoading()
            mainview.isUserInteractionEnabled = false
           // SVProgressHUD.setDefaultMaskType(.clear)
        self.uploadMedia(_image: self.carimage.image!){url in
            self.saveimage(imageurl: url!){ sucess in
                if sucess != nil{
                    print("saved")
                }
                }
            }
            
        }
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Hlo")
        
        if self.Serialno == nil{
            self.addCarButtonOutlet.setTitle("Add Car", for: .normal)
        }
        else{
            self.addCarButtonOutlet.setTitle("Update Car", for: .normal)
        }
    }
    
    // MARK:========Photos-============

  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        carimage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion:nil)
    }
    
}
extension AddNewCarVC{
  // let uid = Auth.auth().currentUser?.uid
    
    func uploadMedia(_image:UIImage,completion: @escaping ((_ url: URL?) -> ())) {
        let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).png")
        let uploadData = self.carimage.image!.pngData()
        let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            storageRef.putData(uploadData!, metadata: metadata) { (metadata, error) in
                if error == nil {
                    storageRef.downloadURL(completion: { (url, error) in
                        completion(url)
                    })
                   self.navigationController?.popViewController(animated: true)
                }
                else {
                    print("error in save image")
                    completion(nil)
                    }
             }
            }

func saveimage(imageurl:URL,completion: @escaping ((_ url: URL?) -> ())){
    //let key = refName?.childByAutoId().key
    let dict = ["id":(UUID().uuidString),"serialno":serialno.text!,"engionno":engionno.text!,"carname":carname.text!,
        "imageurl":imageurl.absoluteString] as [String:Any]
    //refName?.child(key!).setValue(dict)
    self.refName.child("carnames").child(Auth.auth().currentUser!.uid).childByAutoId().setValue(dict)
    
}
   
    func updateData(){
       // let userID = Auth.auth().currentUser!.uid

        let valuesdata = ["serialno": self.serialno.text!  , "engionno": self.engionno.text!,"carname": self.carname.text! ]
        
        let ref : DatabaseReference!
        ref = Database.database().reference()
        let usersRef = ref.child("carnames")
        let queryRef = usersRef.queryOrdered(byChild: "id")
        queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
            //    let groupRef = ref.child("carnames").child(carlist[IndexPath.row].key)
                let id = userSnap.key //the uid of each user
                let value = userSnap.value
                let userDict = userSnap.value as! [String:AnyObject]
                let userid = userDict["key"] as! String
             // let print =  print("key = \(id)  value = \(value!)")
              //  let idd = ("key = \(id)")
                ref.child("carnames").child("\(id)").updateChildValues(valuesdata)
            }
        })
        
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
