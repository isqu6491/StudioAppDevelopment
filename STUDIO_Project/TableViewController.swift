//
//  TableViewController.swift
//  STUDIO_Project
//
//  Created by Israel Quinonez on 3/13/19.
//  Copyright © 2019 Israel Quinonez. All rights reserved.
//

import UIKit



class TableViewController: UITableViewController {
    
    var transferedStruct: BrandedStruct?
    var selectedFoodStruct: FoodItems?

    override func viewDidLoad() {
        super.viewDidLoad()
       // print(transferedStruct);
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return (transferedStruct?.branded.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! UITableViewCell

        // Configure the cell...
        
        var nameList = [""]
        var restaurantList = [""]
        for i in (transferedStruct?.branded)!{
            nameList.append(i.food_name!)
            restaurantList.append(i.brand_name!)
            
        }
        cell.textLabel?.text = nameList[indexPath.row+1]
        cell.detailTextLabel?.text = restaurantList[indexPath.row+1]
        
        //cell.textLabel?.text = "Test"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath =  tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)
        let currentItem = currentCell?.textLabel!.text
        selectedFoodStruct = transferedStruct?.branded[(indexPath?.row)!]
        self.performSegue(withIdentifier: "itemSegue", sender: indexPath!.row)
        
        
            
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var vc = segue.destination as! ItemViewController
        vc.selectedFoodItemsStruct = selectedFoodStruct!
       
    }
    
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
