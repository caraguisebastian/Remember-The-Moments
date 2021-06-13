//
//  AddPlaceViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import UIKit
import RealmSwift

class AddPlaceViewController: UIViewController{
    
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    let realm = try! Realm()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
    }
  
    @IBAction func addPlacePressed(_ sender: UIButton) {
        let newPlace = Place()
        if nameField.text! != "" && imageSelected.image != nil{
            newPlace.name = nameField.text!
            newPlace.imageData = imageSelected.image!.pngData()!
            self.save(place: newPlace)
        } else{
            let alert = UIAlertController(title: "Couldn't add new place", message: "Please add an image and a name!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Try again", style: .cancel, handler: nil)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func save(place: Place){
        do {
            try realm.write{
                realm.add(place)
            }
        } catch {
            print("Error saving place: \(error)")
        }
        
    }
    
}


extension AddPlaceViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBAction func addPicturePressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageSelected.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
