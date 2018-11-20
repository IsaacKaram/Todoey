//
//  ViewController.swift
//  Todoey
//
//  Created by User on 11/11/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = Item()
        item1.title = "Find Makes"
        itemArray.append(item1)
        
        let item2 = Item()
        item2.title = "Do HomeWork"
        itemArray.append(item2)
        
        let item3 = Item()
        item3.title = "buy Milk"
        itemArray.append(item3)
        
        // Do any additional setup after loading the view, typically from a nib.
//        if let TempItemArray = defaults.array(forKey: "ToDoListArray") as? [String]{
//            itemArray = TempItemArray
//        }
    }

    //Mark - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel!.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //Mark - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
    }
    
    //Mark - Add new Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Todoey Item", message:"", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add item", style: .default){ (action) in
        let newItem = Item()
            newItem.title = alertController.textFields![0].text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Create new Item"
        }
        
        alertController.addAction(alertAction)
        // show our alert
        present(alertController, animated: true, completion: nil)
    }
    
}

