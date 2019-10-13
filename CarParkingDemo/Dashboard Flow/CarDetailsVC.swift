//
//  CarDetailsViewController.swift
//  CarParkingDemo
//
//  Created by admin on 10/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class CarDetailsVC: UIViewController {

 
    @IBAction func backbtn(_ sender: UIButton) {
        showloader = true
         self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var carimage: UIImageView!
    @IBOutlet weak var Serialno: UILabel!
    @IBOutlet weak var Engionno: UILabel!
    @IBOutlet weak var Carname: UILabel!
    

    var serialno:String!
    var engionno:String!
    var carname:String!
    var carimages:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Serialno.text = serialno
        Engionno.text = engionno
        Carname.text =  carname
        carimage.image = carimages
    }
    
    


}
