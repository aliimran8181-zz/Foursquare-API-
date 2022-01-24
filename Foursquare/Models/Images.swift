//
//  Images.swift
//  Foursquare
//
//  Created by Ali on 01/12/2021.
//

import Foundation
import Foundation

class Images : NSObject {
      
    var id : String?
    var prefix : String?
    var suffix : String?
    //  var geocodes : Geocodes?
   //   var location : Location?

     init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? String
        prefix = dictionary["prefix"] as? String
        suffix = dictionary["suffix"] as? String
         
    }


}
