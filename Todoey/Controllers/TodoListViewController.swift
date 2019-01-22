//
//  ViewController.swift
//  Todoey
//
//  Created by User on 11/11/18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row]{
            cell.textLabel!.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel!.text = "no Items Added"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("error in saving Items, \(error)")
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Todoey Item", message:"", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add item", style: .default){ (action) in
            
            if let currentCategory = self.selectedCategory{
                let newItem = Item()
                newItem.title = alertController.textFields![0].text!
                newItem.dateCreated = Date()
                do{
                    try self.realm.write {
                      currentCategory.items.append(newItem)
                    }
                    
                }catch{
                    print("error in add new item, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Create new Item"
        }
        
        alertController.addAction(alertAction)
        // show our alert
        present(alertController, animated: true, completion: nil)
    }
    
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}
