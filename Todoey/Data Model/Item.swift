//
//  Item.swift
//  Todoey
//
//  Created by User on 1/19/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
   @objc dynamic var done : Bool = false
   @objc dynamic var title : String = ""
    @objc dynamic var dateCreated : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
