//
//  AddMomentViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import UIKit
import RealmSwift

class AddMomentViewController: UIViewController{
    
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var storyDescription: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var addPictureButtonView: UIView!
    @IBOutlet weak var addMomentButtonView: UIView!
    
    var imagePicker = UIImagePickerController()
    let realm = try! Realm()
    
    var place: Place?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: K.backgroundImage)!)
        textFieldView.backgroundColor = .clear
        addPictureButtonView.backgroundColor = .clear
        addMomentButtonView.backgroundColor = .clear
    }
    
    @IBAction func addMomentPressed(_ sender: UIButton) {
        let newMoment = Moment()
        if storyDescription.text! != "" && imageSelected.image != nil{
            newMoment.story = storyDescription.text!
            newMoment.fileData = imageSelected.image!.pngData()!
            do{
                try self.realm.write{
                    place?.moments.append(newMoment)
                }
            } catch{
                print("Error saving moment \(error)")
            }
            _ = navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Couldn't add new moment", message: "Please add an image and a story!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Try again", style: .cancel, handler: nil)
            
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - UIImagePickerControllerDelegate

extension AddMomentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
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
