//
//  MomentsViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import UIKit
import RealmSwift

class MomentsViewController: UIViewController{
    
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    let realm = try! Realm()
    var moments: Results<Moment>?
    var selectedPlace: Place? {
        didSet{
            loadMoments()
        }
    }
    
    override func viewDidLoad() {
        DispatchQueue.main.async {
            self.placeName.text = self.selectedPlace?.name
        }
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: K.collectionCellNibName, bundle: nil), forCellWithReuseIdentifier: K.collectionCellIdentifier)
        loadMoments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMoments()
    }
    
    func loadMoments(){
        moments = selectedPlace?.moments.sorted(byKeyPath: "story")
        
//        myCollectionView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.addMomentSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddMomentViewController
        destination.place = selectedPlace
    }
}

//MARK: - CollectionViewDataSource methods
extension MomentsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moments?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionCellIdentifier, for: indexPath) as! MomentsCell
        cell.cellImage.image = UIImage(data: moments?[indexPath.row].fileData ?? UIImage(named: "peepoHappy")!.pngData()!)
        return cell
    }
}

extension MomentsViewController: UICollectionViewDelegate{
    
}
