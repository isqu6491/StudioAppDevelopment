//
//  LocationAPI.swift
//  messing
//
//  Created by Israel Quinonez on 3/7/19.
//  Copyright © 2019 Israel Quinonez. All rights reserved.
//

import Foundation



func LocationAPICall(latitude:Double, longitude:Double) -> (String, [String]){
    
    
    var totalString = ""
    var totalBrandId = [String]()
    
    let headers = [
        "x-app-id": "9e3d679d",
        "x-app-key": "7f05afa2326048152853f05b4aded47f",
        "cache-control": "no-cache",
        //"postman-token": "f40ce628-6e32-2dc4-3ec4-d8f82b00e53c"
    ]
    
    let group = DispatchGroup()
    group.enter()
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://trackapi.nutritionix.com/v2/locations?ll=\(String(latitude)),\(String(longitude))&distance=20mi&limit=50")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
            return
        } else {
            //let httpResponse = response as? HTTPURLResponse
            
            guard let data = data else {return}
            
            do{
                let item = try JSONDecoder().decode(LocationsStruct.self, from: data)
                
                
                for i in item.locations{
                    
                    totalString = totalString + " " + i.name!
                    totalBrandId.append(i.brand_id!)
                }
               
                group.leave()
            }
                
            catch let jasonERR{
                
            }
            
        }
    })
    
    dataTask.resume()
    group.wait()
    return (totalString, totalBrandId)
    
}

