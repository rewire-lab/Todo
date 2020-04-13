//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Michael Murray on 4/13/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [`Category`]()
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Catagories.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCatagories()
    
    }

    //MARK: - TableView Datasource Methods
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
       }
     
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    
            cell.textLabel?.text = categories[indexPath.row].name
        
           return cell
       }
       
       //MARK TableView Delegate MEthods
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //print(itemArray[indexPath.row])
            performSegue(withIdentifier: "goToItems", sender: self)
       }
       
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! TodoListViewController
        
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
            }
        }
        
     //MARK: - Data Manipulation Methods
    
    func saveCategories() {
        do {
            try context.save()
            
        } catch {
            print("Error saving context, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCatagories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {

        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetchong data from context \(error)")
        }
        tableView.reloadData()
    }

    //MARK: - Add New Categores
    
   
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            // what happens after add button
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion:nil)
    }
    
    
    
    
    
    
    //MARK: - TableView Delegate Methods
    

    
    
}
