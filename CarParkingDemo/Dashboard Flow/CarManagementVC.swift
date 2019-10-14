//
//  carmanagementViewController.swift
//  CarParkingDemo
//
//  Created by admin on 06/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
// MARK:-----------Variables--------------

//var newCarStatus = true
//var updateCarStatus = false

struct card{
    var serial : String
}
class CarManagementVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    var carlist = [CarDetails]()
    var refName: DatabaseReference!
    
   // @IBOutlet weak var tableindicator: UIActivityIndicatorView!
    var indicator = UIActivityIndicatorView()
    
    // MARK:-----------Outlets--------------
@IBOutlet weak var tableview: UITableView!
    
    @IBOutlet var mainview: UIView!
    // MARK:-----------Did Load--------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayfirebasedata()
        activityIndicator()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       if tableview.visibleCells.isEmpty{
            
            self.indicator.hidesWhenStopped = true
       }else{
        if showloader == false{
        indicator.startAnimating()
        }
        else if showloader == true  {
            self.indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
        }}
    }
    override func viewDidAppear(_ animated: Bool) {
        print("f")
    }
    // MARK:-----------Button Actions--------------

    @IBAction func addcar(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCarVC") as! AddNewCarVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func profilebtn(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func qrcode(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    // MARK:-----------Tableview DataSource--------------

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return carlist.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
     func tableView(_ tableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardetail = self.storyboard?.instantiateViewController(withIdentifier:"CarDetailsVC") as! CarDetailsVC
        
        let user: CarDetails
        user = self.carlist[indexPath.row]
        
        cardetail.serialno = user.serialno
        cardetail.engionno = user.engionno
        cardetail.carname = user.carname
        
        if let url = URL(string: user.imageurl){
            do {
                let data = try Data(contentsOf: url)
                cardetail.carimages = UIImage(data: data)
                
            }catch let err {
                print(" Error : \(err.localizedDescription)")
            }
        }
        
        self.navigationController?.pushViewController(cardetail, animated: true)
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! CARTableViewCell
        let user: CarDetails
        user = carlist[indexPath.row]

        //adding values to labels
        cell.carcode.text = user.serialno
        cell.carengion.text = user.engionno
        cell.carname.text = user.carname
        
        
        if let url = URL(string: user.imageurl){
            
//            cell.Images.sd_addActivityIndicator()
//            cell.Images.sd_showActivityIndicatorView()
                //let data = try Data(contentsOf: url)
             cell.Images.sd_setShowActivityIndicatorView(true)
             cell.Images.sd_setIndicatorStyle(.gray)
                cell.Images.sd_setImage(with: URL(string:"\(url)"),placeholderImage: UIImage(named: ""))
           // cell.Images.sd_ActivityIndicatorView
               // cell.Images.image = UIImage(data: data)
        }

        return cell
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.center = self.tableview.center
        indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        self.view.addSubview(indicator)
    }
    // MARK:-----------Tableview Delegate--------------

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
      //  print(carlist[indexPath.row]["id"])
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            print("edit")
            let sec = self.storyboard?.instantiateViewController(withIdentifier:"AddNewCarVC") as! AddNewCarVC

            let user: CarDetails
            user = self.carlist[indexPath.row]
            
            sec.Serialno = user.serialno
            sec.Engionno = user.engionno
            sec.Carname =  user.carname
            
            if let url = URL(string: user.imageurl){
                do {
                    let data = try Data(contentsOf: url)
                    sec.Carimage = UIImage(data: data)
                    
                }catch let err {
                    print(" Error : \(err.localizedDescription)")
                }
            }
            self.navigationController?.pushViewController(sec, animated: true)

            //TODO: edit the row at indexPath here
        }
        editAction.backgroundColor = .blue

        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
           // self.deleteRow()
            guard let uid = Auth.auth().currentUser?.uid else{return}
            var databaseReference: DatabaseReference!
            databaseReference = Database.database().reference()
            let delcar =  databaseReference.child("carnames").child(uid)
            delcar.removeValue()
            print("del")
           self.carlist.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
   
        }
        deleteAction.backgroundColor = .red

        return [editAction,deleteAction]
    }

    
    // MARK:-----------FIREBASE DATA--------------

    func displayfirebasedata(){
        self.indicator.startAnimating()
        refName = Database.database().reference().child("carnames").child(Auth.auth().currentUser!.uid)
        refName.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.carlist.removeAll()
                
                //iterating through all the values
                for carnames in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = carnames.value as? [String: AnyObject]
                    let serialno  = userObject?["serialno"]
                    let userId  = userObject?["id"]
                 //   UserDefaults.standard.set(userId, forKey: "userId") as? String
                    let engionno = userObject?["engionno"]
                    let carname = userObject?["carname"]
                    let imageurl = userObject?["imageurl"]
                   
                    //creating artist object with model and fetched values
                    let cardetails = CarDetails(id: userId as! String?, serialno: serialno as! String?, engionno: engionno as! String?, carname: carname as? String, imageurl: imageurl as! String)
                    
                    //appending it to list
                   // self.carlist.append(cardetails)
                    self.carlist.insert(cardetails, at: 0)
                }
                //reloading the tableview
               
                self.indicator.startAnimating()
                self.tableview.reloadData()
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
        
            }
        })}

}

