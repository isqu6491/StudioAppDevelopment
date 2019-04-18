//
//  ItemViewController.swift
//  STUDIO_Project
//
//  Created by Israel Quinonez on 4/2/19.
//  Copyright © 2019 Israel Quinonez. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    
    
    var selectedFoodItemsStruct: FoodItems?
    var selectedNutrientValues: [NutrValues]?
    var calories = 0
    var fat = 0
    var carbs = 0
    var protein = 0
    var sugar = 0
    var fiber = 0
    var sodium = 0
    var cholesterol = 0
    var transFat = 0
    var saturatedFat = 0
    var mainMacrosList : [Int]?
    var mainMacroNames = ["Sugar(g)", "Fiber (g)", "Sodium (mg)", "Cholesterol (mg)", "Trans Fat (g)","Saturated Fat (g)"]
    //var dicOfNutrients = NSDictionary[100.0,:0.0]

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var macrosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for i in (selectedFoodItemsStruct?.full_nutrients)!{
            
            if i.attr_id == 208.0{
                
                caloriesLabel.text = String(Int(i.value!))
                calories = Int(i.value!)
            }
            if i.attr_id == 204.0{
               fat = Int(i.value!)
                fatLabel.text = String(Int(i.value!))
            }
            if i.attr_id == 205.0{
                
               carbs = Int(i.value!)
                carbsLabel.text = String(Int(i.value!))
            }
            if i.attr_id == 203.0{
                protein = Int(i.value!)
                proteinLabel.text = String(Int(i.value!))
            }
            if i.attr_id == 269{
                
                sugar = Int(i.value!)
            }
            if i.attr_id == 291{
                
                fiber = Int(i.value!)
            }
            if i.attr_id == 307{
                
                sodium = Int(i.value!)
            }
            if i.attr_id == 601{
                
                cholesterol = Int(i.value!)
            }
            if i.attr_id == 605{
                
                transFat = Int(i.value!)
            }
            if i.attr_id == 606{
                
                saturatedFat = Int(i.value!)
            }
            
        }
        
      
       
        mainMacrosList = [sugar,fiber,sodium,cholesterol,transFat,saturatedFat]

        macrosTableView.tableFooterView = UIView()
        macrosTableView.reloadData()
        
        //for i in selectedNutrientValues!{
          //  dicOfNutrients![i.attr_id!] = i.value
            
        //}
        itemName.text = selectedFoodItemsStruct?.food_name
        restaurantNameLabel.text = selectedFoodItemsStruct?.brand_name
        //restaurantNameLabel.text = (selectedFoodItemsStruct?.serving_unit)! + "" + String((selectedFoodItemsStruct?.serving_qty)!)
        
        
       
        
        print("test")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (mainMacrosList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "macrosCell", for: indexPath) as! MainMacrosTableViewCell
        for i in mainMacrosList!{
            
            var stringVariable = mainMacrosList![indexPath.row]
            cell.macroNameLabelCell.text = mainMacroNames[indexPath.row]
            cell.maroValueLabelCell.text = String(stringVariable)
         //   cell.mainMacroCellImaeg.image = UIImage(named: "Image-1")
            
        }
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
