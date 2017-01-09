//
//  ViewController.swift
//  ToDoList
//
//  Created by Student on 11/29/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    var items: [Items] = []

    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        if let savedItems = defaults.object(forKey: "items") as? Data
        {
            items = (NSKeyedUnarchiver.unarchiveObject(with: savedItems) as? [Items])!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return items.count
    }
    @IBAction func addButtonTapped(_ sender: Any)
    {
        alert()
        myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem") as! TableViewCell
        cell.textLabel?.text = items[indexPath.row].title
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.gray.cgColor
        if cell.completed
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        self.save()
        return cell
    }
    
    func save()
    {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: items)
        
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "items")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            items.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myTableView.deselectRow(at: indexPath, animated: true)
        let cell = myTableView.cellForRow(at: indexPath)
        let item = items[indexPath.row]
        item.completed = !item.completed
        if item.completed
        {
            cell?.accessoryType = UITableViewCellAccessoryType.checkmark
            self.save()
        }
        
        else
        {
            cell?.accessoryType = UITableViewCellAccessoryType.none
            self.save()
        }
        self.save()
    }
    
    func alert()
    {
       let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
    
        alert.addTextField { (textField) -> Void in
        textField.placeholder = "Add your priorities"
        
        let addAction = UIAlertAction(title: "Add", style: .default)
        { (addAction) -> Void in
            
            let textField = alert.textFields![0] as UITextField
            self.items.append(Items(title: textField.text!))
            self.myTableView.reloadData()
            self.save()
        }
            alert.addAction(addAction)
        }
            
            self.present(alert, animated: true, completion: nil)
            self.save()
        }
        
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
        {
            return true
        }
}
        































