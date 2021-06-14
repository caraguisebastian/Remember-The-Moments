//
//  SingleMomentViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 14.06.2021.
//

import UIKit
import RealmSwift

class SingleMomentViewController: UIViewController{
    
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    let realm = try! Realm()
    var selectedMomemt: Moment?
    
    override func viewDidLoad() {
        if let moment = selectedMomemt{
            label.text = moment.story
            imageView.image = UIImage(data: moment.fileData)
            favoriteButton.image = moment.favorite ?  UIImage(systemName: "heart.slash.fill") : UIImage(systemName: "heart.fill")
            labelView.backgroundColor = .clear
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: K.backgroundImage)!)
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if let moment = selectedMomemt{
            do{
                try realm.write{
                    moment.favorite = !moment.favorite
                }
            } catch{
                print("Error marking as favorite, \(error)")
            }
            DispatchQueue.main.async {
                self.favoriteButton.image = moment.favorite ?  UIImage(systemName: "heart.slash.fill") : UIImage(systemName: "heart.fill")
            }
        }
    }
}

