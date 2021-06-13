//
//  ViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import UIKit
import RealmSwift

class PlacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var places: Results<Place>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadPlaces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPlaces()
    }
    
    func loadPlaces() {
        places = realm.objects(Place.self)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.momentsSegue{
            let destination = segue.destination as! MomentsViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destination.selectedPlace = places?[indexPath.row]
            }
        }
    }

}

//MARK: - TableViewDataSource methods

extension PlacesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PlacesCell
        cell.label.text = places?[indexPath.row].name ?? "No places added yet"
        cell.leftImage.image = UIImage(data: places?[indexPath.row].imageData ?? UIImage(named: "peepoHappy")!.pngData()!)
        return cell
    }
    
    
}

// MARK: - TableViewDelegate Methods


extension PlacesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.momentsSegue, sender: self)
    }
    
}
