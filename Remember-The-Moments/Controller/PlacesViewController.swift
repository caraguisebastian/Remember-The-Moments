//
//  ViewController.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import UIKit

class PlacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
    }


}




extension PlacesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCellIdentifier", for: indexPath)
        
        return cell
    }
    
    
}
