//
//  CategoryViewController.swift
//  Todoey
//
//  Created by User on 1/15/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class CategoryViewController: UITableViewController {

    var Categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

loadCategories()
    }

    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return Categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel!.text = Categories[indexPath.row].name
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destantionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destantionVC.selectedCategory = Categories[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func SaveCategories(){
        do{
            try context.save()
        }catch{
            print("error saving Category in context\(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            Categories = try  context.fetch(request)
        }catch{
           print("error read Category from context\(error)")
        }
    }
    
    @IBAction func addButtonPressd(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { (UIAlertAction) in
            let newCategory = Category(context: self.context)
            newCategory.name = alertController.textFields![0].text!
            self.Categories.append(newCategory)
            self.SaveCategories()
        }
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Create new Category"
        }
        
        alertController.addAction(alertAction)
        // show our alert
        present(alertController, animated: true, completion: nil)
        
    }
   
    
}
