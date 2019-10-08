//
//  HelplineViewController.swift
//  CarParkingDemo
//
//  Created by admin on 27/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class HelplineVC: UIViewController {
    
    @IBOutlet weak var backbtnoutlet: UIButton!
    @IBAction func callbtnaction(_ sender: UIButton) {
        call()
    }
    
    @IBOutlet weak var callbtn: UIButton!
    
    @IBAction func backbtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backbtnoutlet.contentVerticalAlignment = .fill
        backbtnoutlet.contentHorizontalAlignment = .fill
        backbtnoutlet.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func call(){
        guard let number = URL(string: "tel://" + "+16543456765") else { return }
        UIApplication.shared.open(number)
    }
    
}
