
import Foundation
 
class Categories : NSObject {
	 var id : Int?
	 var name : String?
	 var icon : Icon?



	init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		if (dictionary["icon"] != nil) { icon = Icon(dictionary: dictionary["icon"] as! NSDictionary) }
	}
}
class Icon : NSObject{
    var prefix : String?
    var suffix : String?
    init?(dictionary: NSDictionary) {

        prefix = dictionary["prefix"] as? String
        suffix = dictionary["suffix"] as? String
    }
}
