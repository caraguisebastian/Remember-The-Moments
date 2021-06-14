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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var placeNameView: UIView!
    @IBOutlet weak var viewOfCollectionView: UIView!
    
    let realm = try! Realm()
    var selectedMoment: Moment?
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: K.collectionCellNibName, bundle: nil), forCellWithReuseIdentifier: K.collectionCellIdentifier)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: K.backgroundImage)!)
        collectionView.backgroundColor = .clear
        viewOfCollectionView.backgroundColor = .clear
        placeNameView.backgroundColor = .clear
        loadMoments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMoments()
    }
    
    func loadMoments(){
        moments = selectedPlace?.moments.sorted(byKeyPath: "favorite", ascending: false)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.addMomentSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.addMomentSegue{
            let destination = segue.destination as! AddMomentViewController
            destination.place = selectedPlace
        } else{
            let destination = segue.destination as! SingleMomentViewController
            destination.selectedMomemt = selectedMoment
        }
    }
}

//MARK: - CollectionViewDataSource methods
extension MomentsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moments?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionCellIdentifier, for: indexPath) as! MomentsCell
        if let moment = moments?[indexPath.row]{
        cell.cellImage.image = UIImage(data: moment.fileData)
        cell.backgroundColor = .clear
        cell.star.isHidden = moment.favorite ? false : true
        }
        return cell
    }
}


//MARK: - CollectionViewDelegate methods
extension MomentsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMoment = moments?[indexPath.row]
        performSegue(withIdentifier: K.singleMoment, sender: self)
    }
}
