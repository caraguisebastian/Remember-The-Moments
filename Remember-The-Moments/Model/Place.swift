//
//  Places.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import Foundation
import RealmSwift

class Place: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data =  UIImage(named:"peepoHappy")!.pngData()!
    
}
