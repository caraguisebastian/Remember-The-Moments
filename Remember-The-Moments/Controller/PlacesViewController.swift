//
//  ViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import UIKit
import RealmSwift
import SwipeCellKit

class PlacesViewController: UIViewController {
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var places: Results<Place>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 100
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: K.backgroundImage)!)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: K.backgroundImage), for: .default)
        tableView.backgroundColor = .clear
        if var textAttributes = navigationController?.navigationBar.titleTextAttributes {
            textAttributes[NSAttributedString.Key.foregroundColor] = UIColor.systemGray3
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
        mySearchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationItem.setHidesBackButton(true, animated: true)
        loadPlaces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPlaces()
    }
    
    func loadPlaces() {
        places = realm.objects(Place.self)
        tableView.reloadData()
    }
    
    func updateModel(at indexPath: IndexPath) {
        if let placeForDeletion = self.places?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(placeForDeletion.moments)
                    self.realm.delete(placeForDeletion)
                }
            } catch{
                print("Error deleting category, \(error)")
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableViewCell) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = places?[indexPath.row].name ?? "No places added yet"
        cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.imageView?.image = UIImage(data: places?[indexPath.row].imageData ?? UIImage(named: "peepoHappy")!.pngData()!)
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - TableViewDelegate Methods


extension PlacesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.momentsSegue, sender: self)
    }
}


// MARK: - SwipeTableViewCellDelegate methods
extension PlacesViewController: SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateModel(at: indexPath)
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}

//MARK: - SearchBarDelegate Methods
extension PlacesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        places = places?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadPlaces()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
