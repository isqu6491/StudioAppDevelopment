//
//  FoodSearchAPI.swift
//  STUDIO_Project
//
//  Created by Israel Quinonez on 3/7/19.
//  Copyright © 2019 Israel Quinonez. All rights reserved.
//

import Foundation



func SearchFoodAPI( totalQuery: String, brandIds: [String], maxCalories: Int, minCalories: Int, maxFat: Int, minFat: Int, maxCarbs: Int, minCarbs: Int, maxProtein: Int, minProtein: Int) -> (BrandedStruct){
    
    
    var returnString = ""
    var valuesStruct = NutrValues.init(value: 0.0, attr_id: 0.0)
    var foodStruct = FoodItems.init(food_name: "", nix_brand_id: "", brand_name: "", full_nutrients: [valuesStruct], serving_unit: "", serving_qty: 0.0)
    var item2 = BrandedStruct.init(branded: [foodStruct])
    
    
    let headers2 = [
        "x-app-id": "9e3d679d",
        "x-app-key": "7f05afa2326048152853f05b4aded47f",
        "cache-control": "no-cache",
        "Content-Type" : "application/json"
    ]
    
    
    var body = Dictionary< String, Any >()
    body = [
        
        //"query" : "Subway Subway Subway Jamba Juice Panda Express Papa John's Papa John's Starbucks Del Taco Jimmy John's Starbucks Einstein Bros. Bagels Silver Mine Subs Taco Bell Wendy's Wendy's Starbucks Subway Noodles & Company Papa John's Papa John's Subway Nothing Bundt Cakes Le Peep Tokyo Joe's Larkburger Starbucks Denny's Cold Stone Creamery IHOP Qdoba Smashburger Noodles & Company IHOP McDonald's Domino's Einstein Bros. Bagels Chipotle PizzaRev PizzaRev",
         "query" : totalQuery,
        "common": "false",
        "self": "false",
        "branded": "true",
        "branded_region": 1,
        "branded_type": 1,
        "detailed": "true",
        "full_nutrients": [
            "203": [
                "gte": minProtein,
                "lte": maxProtein//Protein
                
                
            ],
            "204": [            //Fat
                "lte": maxFat,
                "gte": minFat
                
            ],
            "205": [           //Carbs
                
                "lte": maxCarbs,
                "gte": minCarbs
            ],
            "208":[                 //Calories
                "lte": maxCalories,
                "gte": minCalories
            ]
        ],
        "brand_ids": brandIds
        
    ]
    
    let data2 = try? JSONSerialization.data(withJSONObject: body)

    let group2 = DispatchGroup()
    group2.enter()
    
    let request2 = NSMutableURLRequest(url: NSURL(string: "https://trackapi.nutritionix.com/v2/search/instant")! as URL,
                                       cachePolicy: .useProtocolCachePolicy,
                                       timeoutInterval: 10.0)
    request2.httpMethod = "POST"
    request2.allHTTPHeaderFields = headers2
    request2.httpBody = data2
    
    let session2 = URLSession.shared
    let dataTask2 = session2.dataTask(with: request2 as URLRequest, completionHandler: { (data3, response2, error2) -> Void in
        if (error2 != nil) {
            print(error2)
        } else {
           let httpResponse = response2 as? HTTPURLResponse
          //  print(httpResponse)
            guard let data3 = data3 else {return}
            
            do{
                let item3 = try JSONDecoder().decode(BrandedStruct.self, from: data3)
                item2 = item3
                
                // var totalString = ""
                //   var totalBrandId = ""
               // for e in item2.branded{
                    
                    //  totalString = totalString + " " + i.name!
                    //    totalBrandId = totalBrandId + " " + i.brand_id!
                    
                    //print(i.food_name)
                    //  print(i.nix_brand_id)
                   /// returnString = returnString + " " + e.food_name!
                    ///for h in e.full_nutrients{
                        
                        // print(h.value)
                        
                        
                   // }
               // }
                
                
            }
                
            catch let jasonERR2{
                print("could not run decoder")
                
                
            }
            
            group2.leave()
            
        }
    })
    
    dataTask2.resume()
    group2.wait()
    return item2
    
    
}





