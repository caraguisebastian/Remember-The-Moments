//
//  Moment.swift
//  Remember-The-Moments
//
//  Created by Radu Mihaiu on 13.06.2021.
//

import Foundation
import RealmSwift

class Moment: Object{
    @objc dynamic var story: String = ""
    @objc dynamic var fileData: Data =  UIImage(named:"peepoHappy")!.pngData()!
    @objc dynamic var favorite: Bool = false
    var parentCategory = LinkingObjects(fromType: Place.self, property: "moments")
}
