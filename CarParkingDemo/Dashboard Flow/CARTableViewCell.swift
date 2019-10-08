//
//  CARTableViewCell.swift
//  CarParkingDemo
//
//  Created by admin on 10/09/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit


class CARTableViewCell: UITableViewCell {

   
    @IBOutlet weak var Images: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var carcode: UILabel!
    @IBOutlet weak var carengion: UILabel!
    @IBOutlet weak var carname: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
