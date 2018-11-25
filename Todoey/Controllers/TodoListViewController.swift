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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
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
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add new Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Todoey Item", message:"", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add item", style: .default){ (action) in
        let newItem = Item()
            newItem.title = alertController.textFields![0].text!
            
            self.itemArray.append(newItem)
           self.saveItems()
            
        }
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Create new Item"
        }
        
        alertController.addAction(alertAction)
        // show our alert
        present(alertController, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Catch new error \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            }catch {
              print("Catch new error decoding Items \(error)")
            }
        }
    }
}

