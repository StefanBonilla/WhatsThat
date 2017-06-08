//
//  ImageIdentifyer.swift
//  WhatsThat
//
//  Created by Stefan Bonilla on 6/6/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit

class ImageIdentifyer: UIViewController {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var pictureLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    
    var imageData: UIImage?
    var resultName: String!
    var resultConfidence: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureView.image = imageData
        pictureLabel.text = resultName
        confidenceLabel.text = resultConfidence
    }

}
