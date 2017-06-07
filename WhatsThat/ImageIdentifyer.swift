//
//  ImageIdentifyer.swift
//  WhatsThat
//
//  Created by Stefan Bonilla on 6/6/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ImageIdentifyer: UIViewController {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var pictureLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    
    var imageData: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureView.image = imageData
        
        let ciPic = CIImage(image: pictureView.image!)
        let cgPic = convertCIImageToCGImage(inputImage: ciPic!)
        
        let model = try? VNCoreMLModel(for: Resnet50().model)
        let request = VNCoreMLRequest(model: model!, completionHandler: identifyImage)
        let handler = VNImageRequestHandler(cgImage: cgPic!)
        try? handler.perform([request])
    }
    
    func identifyImage(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("huh") }
        
        let topResult = results[0]
        pictureLabel.text = topResult.identifier
        confidenceLabel.text = String(topResult.confidence)
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        return context.createCGImage(inputImage, from: inputImage.extent)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
