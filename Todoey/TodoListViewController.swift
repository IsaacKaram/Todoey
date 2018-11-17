//
//  ViewController.swift
//  Todoey
//
//  Created by User on 11/11/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggs", "Sell Laptop"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let TempItemArray = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = TempItemArray
        }
    }

    //Mark - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel!.text = itemArray[indexPath.row]
        return cell
    }
    
    //Mark - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add new Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Todoey Item", message:"", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add item", style: .default){ (action) in
        let newItem = alertController.textFields![0] as UITextField
            self.itemArray.append(newItem.text!)
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

