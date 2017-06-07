//
//  ImageListCell.swift
//  WhatsThat
//
//  Created by Stefan Bonilla on 6/6/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit

class ImageListCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
