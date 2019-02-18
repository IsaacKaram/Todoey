//
//  CategoryViewController.swift
//  Todoey
//
//  Created by User on 1/15/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    

    let realm = try! Realm()
    
    var Categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }

    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = Categories?[indexPath.row]{
            cell.textLabel!.text = category.name
            
            if let categorycolor = UIColor(hexString: category.categoryColor){
                cell.backgroundColor = categorycolor
                cell.textLabel?.textColor = ContrastColorOf(categorycolor, returnFlat: true)
            }
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destantionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destantionVC.selectedCategory = Categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func SaveCategory(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("error saving Category in context\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        Categories = realm.objects(Category.self)
        
    }
    
    //Mark: - Delete Category
    override func updateModel(indexPath: IndexPath) {
        if let categoryForDeletion = self.Categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print ("error in category delete, \(error)")
            }
        }
    }
    
    @IBAction func addButtonPressd(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (UIAlertAction) in
            let newCategory = Category()
            newCategory.name = alertController.textFields![0].text!
            newCategory.categoryColor = UIColor.randomFlat.hexValue()
            self.SaveCategory(category: newCategory)
        }
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Create new Category"
        }
        
        alertController.addAction(alertAction)
        // show our alert
        present(alertController, animated: true, completion: nil)
        
    }
   
    
}
