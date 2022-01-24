//
//  infoAPI.swift
//  Foursquare
//
//  Created by Ali on 10/12/2021.
//
import Foundation
import UIKit

class infoAPIManager{
var infoArr = [Results]()

func loadData(fsqid: String, completed: @escaping([Results]) -> ()) -> Void{
    
    let headers = [
      "Accept": "application/json",
      "Authorization": "fsq3KnLTCdMzGgbaxtU1+N42kB9gcOzgfQa8RKzChmcc67g="
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqid)")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if let myData = data {
             // print(myData)
              if let json = try? JSONSerialization.jsonObject(with: myData, options: []) as? AnyObject{
                  self.infoArr = self.parsetips(responseArr: json as! NSArray) as! [Results]
                //  print(self.imageArr.count)
                   DispatchQueue.main.async {
                       completed(self.infoArr)
                  }
              }
              
              else {
                  print("Error");
              }
          }
        //print(error)
     
    })

    dataTask.resume()
}
//MARK: PARSING DATA INTO ARRAY
 func parsetips(responseArr:NSArray) -> NSMutableArray
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

