//
//  ImagePicker.swift
//  WhatsThat
//
//  Created by Stefan Bonilla on 6/6/17.
//  Copyright © 2017 Stefan Bonilla. All rights reserved.
//

import UIKit

class ImagePicker: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.navigationController?.present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            images.append(image)
            self.tableView.reloadData()
        } else {
            print("ERROR")
        }
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
        performSegue(withIdentifier: "identifyImage", sender: tableView.cellForRow(at: indexPath) as! ImageListCell)
    }
 
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "identifyImage" {
            let vc = segue.destination as! ImageIdentifyer
            let cell = sender as! ImageListCell
            let indexPath = self.tableView.indexPath(for: cell)!
            vc.imageData = images[indexPath.row]
        }
    }

}
