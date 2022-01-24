
import Foundation

class Results : NSObject {
      var fsq_id : String?
      var categories = [Categories]()
      var distance : Int?
    //  var geocodes : Geocodes?
   //   var location : Location?
      var name : String?
   //   var related_places : Related_places?
      var timezone : String?


	 init?(dictionary: NSDictionary) {
         if let activeDict = dictionary["categories"] as? NSArray
         {
             for active in activeDict
             {
                 if let userDict = active as? NSDictionary
                 {
                     let activeObj = Categories(dictionary: userDict)!
                     self.categories.append(activeObj)
                 }
             }
             
         }

		distance = dictionary["distance"] as? Int
		name = dictionary["name"] as? String
		timezone = dictionary["timezone"] as? String
        fsq_id = dictionary["fsq_id"] as? String
	}


}
