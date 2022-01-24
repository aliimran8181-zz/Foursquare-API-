
//
//  Images.swift
//  Foursquare
//
//  Created by Ali on 01/12/2021.
//

import Foundation
import Foundation

class tips : NSObject {
      
    var id : String?
    var created_at : String?
    var text : String?


     init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? String
        created_at = dictionary["created_at"] as? String
        text = dictionary["text"] as? String
         
    }


}
