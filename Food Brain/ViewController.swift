//
//  ViewController.swift
//  Food Brain
//
//  Created by argenis delarosa on 11/20/19.
//  Copyright © 2019 argenis delarosa. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("This one did not work")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("this message has failed")
            }
            
            print(results)
        }
        
    }
    
    // MARK: - Navigation Bar Button Items
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func photoLibraryTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
}

// MARK: - Image Picker Delegates 

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userImagePicked = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userImagePicked
            
            guard let ciImage = try? CIImage(image: userImagePicked) else {
                fatalError("Loading not happening")
            }
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
