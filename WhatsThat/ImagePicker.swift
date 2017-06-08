//
//  ImagePicker.swift
//  WhatsThat
//
//  Created by Stefan Bonilla on 6/6/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ImagePicker: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var images: [UIImage] = []
    var imageUrls: [URL] = []
    
    let model = try? VNCoreMLModel(for: Resnet50().model)
    var request: VNCoreMLRequest!
    var handler: VNImageRequestHandler!
    
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.request = VNCoreMLRequest(model: model!, completionHandler: identifyImage)
    }
    
    // MARK: - ML
    
    func identifyImage(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else { fatalError("huh") }
        let topResult = results[0]
        performSegue(withIdentifier: "identifyImage", sender: topResult)
    }
    
    // MARK: - Image Picker
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.navigationController?.present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageUrl = info[UIImagePickerControllerImageURL] as! URL
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        images.append(image)
        imageUrls.append(imageUrl)
        self.tableView.reloadData()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailCell", for: indexPath) as! ImageListCell
        cell.thumbnail.image = images[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.handler = VNImageRequestHandler(url: imageUrls[indexPath.row])
        try? handler.perform([request])
    }
 
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "identifyImage" {
            let vc = segue.destination as! ImageIdentifyer
            let result = sender as! VNClassificationObservation
            vc.imageData = images[self.selectedRow!]
            vc.resultName = result.identifier
            vc.resultConfidence = String(result.confidence)
        }
    }

}
