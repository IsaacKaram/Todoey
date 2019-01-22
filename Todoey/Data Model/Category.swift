//
//  Category.swift
//  Todoey
//
//  Created by User on 1/19/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}

