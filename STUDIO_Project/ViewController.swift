//
//  ViewController.swift
//  Main_Project2
//
//  Created by Israel Quinonez on 3/3/19.
//  Copyright © 2019 Israel Quinonez. All rights reserved.
//

import UIKit
import CoreLocation

struct LocationsStruct : Decodable{
    let locations: [Restaurants]
    
}
struct Restaurants : Decodable{
    let name: String?
    let brand_id: String?
}

struct BrandedStruct : Decodable{
    let branded: [FoodItems]
    
}
struct FoodItems : Decodable{
    let food_name: String?
    let nix_brand_id: String?
    let brand_name: String?
    let full_nutrients: [NutrValues]
    let serving_unit: String?
    let serving_qty: Double?
}

struct NutrValues : Decodable{
    let value: Double?
    let attr_id: Double?
    
}



class ViewController: UIViewController, CLLocationManagerDelegate {
    var latitude: Double?
    var longitude: Double?
    var locationManager = CLLocationManager()
    var sendStruct: BrandedStruct?
    var fatMax = true
    var carbMax = true
    var proteinMax = false
    var currentCalories = 400
    var currentFat = 40
    var currentCarbs = 60
    var currentProtein = 20
    var maxCalories = 1000
    var minCalories = 0
    var maxFat = 1000
    var minFat = 0
    var maxCarbs = 1000
    var minCarbs = 0
    var maxProtein = 1000
    var minProtein = 0
    
    
    
    @IBAction func button(_ sender: Any) {
        
        if fatMax == true{
            
            maxFat = currentFat
            minFat = 0
        }
        else{
            minFat = currentFat
            maxFat = 1000
        }
        if carbMax == true{
            maxCarbs = currentCarbs
            minCarbs = 0
        }
        else{
            minCarbs = currentCarbs
            maxCarbs = 1000
        }
        if proteinMax == true{
            
            maxProtein = currentProtein
            minProtein = 0
        }
        else{
            
            minProtein = currentProtein
            maxProtein = 1000
        }
        maxCalories = Int(calorieLabel.text!)!
       // minProtein = Int(proteinLabel.text!)!
       // maxFat = Int(fatLabel.text!)!
     //   maxCarbs = Int(fatLabel.text!)!
        print(maxFat)
        print(maxCarbs)
        print(maxProtein)
        print("")
        print(minFat)
        print(minCarbs)
        print(minProtein)
        sendStruct = Search(lati: latitude!, longi: longitude!);
        performSegue(withIdentifier: "resultsSegue", sender: self)
        //let latitudePass = latitude;
       // let longitudePass = longitude;
    }
    
    
    
    @IBAction func calorieSlider(_ sender: UISlider) {
        
    
        calorieLabel.text = String(Int(sender.value))
        currentCalories = Int(sender.value)
      
    }
    
    @IBAction func fatSlider(_ sender: UISlider) {
        fatLabel.text = String(Int(sender.value))+"g"
        currentFat = Int(sender.value)
        
    }
    
    @IBAction func carbSlider(_ sender: UISlider) {
        if sender.value >= (calorieSliderOutlet.value/4 - proteinSliderOutlet.value){
            
            sender.value = calorieSliderOutlet.value/4 - proteinSliderOutlet.value
        }
        
        carbLabel.text = String(Int(sender.value))+"g"
        
        currentCarbs = Int(sender.value)
    }
    
    @IBAction func proteinSlider(_ sender: UISlider) {
        
        if sender.value >= calorieSliderOutlet.value/4{
            sender.value = calorieSliderOutlet.value/4
        }
        proteinLabel.text = String(Int(sender.value))+"g"
        
        
        currentProtein = Int(sender.value)
    }
    
    @IBAction func fatMaxMinSwitch(_ sender: UIButton) {
      
        if sender.currentTitle == "min"{
            
            fatSliderOutlet.minimumTrackTintColor = UIColor(red: 0.847, green: 0.467, blue: 0.325, alpha: 1.0)
            fatSliderOutlet.maximumTrackTintColor = UIColor.lightGray
            sender.setTitle("max", for: .normal)
            fatMax = true
            fatMinMaxLabelOutlet.text = "<"
        }
        else if sender.currentTitle == "max" {
            
            fatSliderOutlet.maximumTrackTintColor = UIColor(red: 0.847, green: 0.467, blue: 0.325, alpha: 1.0)
            fatSliderOutlet.minimumTrackTintColor = UIColor.lightGray
            sender.setTitle("min", for: .normal)
            fatMax = false
            fatMinMaxLabelOutlet.text = ">"
           }
    }
    
    @IBAction func carbsMinMaxSwitch(_ sender: UIButton) {
        if sender.currentTitle == "min"{
            
            carbSliderOutlet.minimumTrackTintColor = UIColor(red: 0.298, green: 0.596, blue: 0.776, alpha: 1.0)
            carbSliderOutlet.maximumTrackTintColor = UIColor.lightGray
            sender.setTitle("max", for: .normal)
            carbMax = true
            carbMinMaxLabelOutlet.text = "<"
        }
        else if sender.currentTitle == "max" {
            
            carbSliderOutlet.maximumTrackTintColor = UIColor(red: 0.298, green: 0.596, blue: 0.776, alpha: 1.0)
            carbSliderOutlet.minimumTrackTintColor = UIColor.lightGray
            sender.setTitle("min", for: .normal)
            carbMax = false
            carbMinMaxLabelOutlet.text = ">"
        }
    }
    @IBAction func proteinMinMaxSwitch(_ sender: UIButton) {
        if sender.currentTitle == "min"{
            
            proteinSliderOutlet.minimumTrackTintColor = UIColor(red: 0.624, green: 0.820, blue: 0.506, alpha: 1.0)
            proteinSliderOutlet.maximumTrackTintColor = UIColor.lightGray
            sender.setTitle("max", for: .normal)
            proteinMax = true
            proteinMinMaxLabelOutlet.text = "<"
        }
        else if sender.currentTitle == "max" {
            
            proteinSliderOutlet.maximumTrackTintColor = UIColor(red: 0.624, green: 0.820, blue: 0.506, alpha: 1.0)
            proteinSliderOutlet.minimumTrackTintColor = UIColor.lightGray
            sender.setTitle("min", for: .normal)
            proteinMax = false
            proteinMinMaxLabelOutlet.text = ">"
        }
    }
    
    @IBOutlet weak var proteinSliderOutlet: UISlider!
    @IBOutlet weak var fatSliderOutlet: UISlider!
    
    @IBOutlet weak var carbSliderOutlet: UISlider!
    @IBOutlet weak var calorieSliderOutlet: UISlider!
    
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var carbLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    
    @IBOutlet weak var fatSwitchOutlet: UIButton!
    
    @IBOutlet weak var fatMinMaxLabelOutlet: UILabel!
    
    @IBOutlet weak var carbMinMaxLabelOutlet: UILabel!
    @IBOutlet weak var proteinMinMaxLabelOutlet: UILabel!
    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! TableViewController;
        vc.transferedStruct = sendStruct;
    }
    
  
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
       
        
       
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            }
        latitude = locationManager.location?.coordinate.latitude
        longitude = locationManager.location?.coordinate.longitude
        
      
       
        
    
        
        
        
       
        
    }
    
    func Search( lati: Double, longi: Double) -> BrandedStruct {
        
        
        
        let (totalString1 , totalBrandId1) = LocationAPICall(latitude: lati, longitude: longi)
        
       // print(totalBrandId1)
        
        let (returnedFoodNames) = SearchFoodAPI(totalQuery: totalString1, brandIds: totalBrandId1, maxCalories: maxCalories, minCalories: minCalories, maxFat: maxFat, minFat: minFat, maxCarbs: maxCarbs, minCarbs: minCarbs, maxProtein: maxProtein, minProtein: minProtein)
        
        
        // print(totalString1 + "supposed1")
        // print(totalBrandId1 + "supposed2")
       // for i in returnedFoodNames.branded{
         //   print(i.food_name)
     //   }
      //  print("test")
        return returnedFoodNames
    }
    //func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       // guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return}
     //  latitude.
        // print(locValue.latitude)
       // print(locValue.longitude)
   // }
    
    
    
    
    
    
}

