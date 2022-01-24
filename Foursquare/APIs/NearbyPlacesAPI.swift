//
//  NearbyPlacesAPI.swift
//  Foursquare
//
//  Created by Ali on 09/12/2021.
//

import Foundation
import UIKit
class nearbyApiManager{

var placeResultArr = [Results]()
    func loadData(longitude: Double, latitude: Double, completed: @escaping([Results]) -> ()) -> Void{
    
    let headers = [
      "Accept": "application/json",
      "Authorization": "fsq3KnLTCdMzGgbaxtU1+N42kB9gcOzgfQa8RKzChmcc67g="
    ]
       
      //  print(longitude)
      //  print(latitude)
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/nearby?ll=\(latitude)%2C\(longitude)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
       // print(request)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let myData = data {
                print(myData)
                if let json = try? JSONSerialization.jsonObject(with: myData, options: []) as? NSDictionary {
                //  print(json)
                    if let dataRes = json.object(forKey: "results") as? NSArray
                    {
                     //   print(dataRes)
                        self.placeResultArr = self.parsePlaces(responseArr: dataRes) as! [Results]
                      //  print(self.placeResultArr.count)
                       
                            completed(self.placeResultArr)
                       
                        
                    }
                    
                } else {
                    print("Error");
                }
            }
        }
        )
        dataTask.resume()
}

//MARK: PARSING DATA INTO ARRAY
 func parsePlaces(responseArr:NSArray) -> NSMutableArray
   {
       let placesArr:NSMutableArray = NSMutableArray()
       
       for places in responseArr
       {
           if let placesDict = places as? NSDictionary
           {
               let placesObj = Results(dictionary: placesDict)
               placesArr.add(placesObj!)
           }
       }
       
       return placesArr
   }
}
