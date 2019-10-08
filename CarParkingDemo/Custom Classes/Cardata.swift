//
//  Cardata.swift
//  CarParkingDemo
//
//  Created by admin on 11/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class CarDetails {
    
    var id: String?
    var serialno: String?
    var engionno: String?
    var carname: String?
    var imageurl:String=""
    
    init(id: String?,serialno: String?, engionno: String?, carname: String?,imageurl: String=""){
        
        self.id=id
        self.serialno = serialno
        self.engionno = engionno
        self.carname = carname
        self.imageurl = imageurl
        
    }
}
