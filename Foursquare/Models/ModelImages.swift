//
//  ModelImages.swift
//  Foursquare
//
//  Created by Ali on 30/11/2021.
//

import Foundation
class ModelImages : NSObject {
    var Images = [Images]



     init?(dictionary: NSDictionary) {
         if let activeDict = dictionary["categories"] as? NSArray
         {
             for active in activeDict
             {
                 if let userDict = active as? NSDictionary
                 {
                     let activeObj = ModelImages(dictionary: userDict)!
                     self.Images.append(activeObj)
                 }
             }
             
         }

        
    }


}
