//
//  placeDetailVC.swift
//  Foursquare
//
//  Created by Ali on 30/11/2021.
//

import UIKit
import SDWebImage
class placeDetailVC: UIViewController{
    
    //MARK: Variables
    var imageArr = [Images]()
    var fsqid = ""
    var titlelbl = ""
    var category = ""
    var result = [Images]()
    var perfix = ""
    var suffix = ""
    var titleImgURL = ""
    var collectionImgURL = ""
    let apimanager = ApiManager()
    var photosView : UIView!
    var Tipsview : UIView!
    var Infoview : UIView!
    var placesView : UIView!
    var tips = TipsView()
    
    //MARK: IBOutlets
    
    @IBOutlet weak var PhotosCon: UIView!
    @IBOutlet weak var InfoCon: UIView!
    @IBOutlet weak var PlacesCon: UIView!
    @IBOutlet weak var TipsCon: UIView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var Categorylbl: UILabel!
    
    
    
    //MARK: ViewdidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(fsqid)
        
        PhotosCon.isHidden = false
        InfoCon.isHidden = true
        PlacesCon.isHidden = true
        TipsCon.isHidden = true
        
        
        apimanager.loadData(fsqid: fsqid) { (results) in
            self.imageArr = results
            //print(self.imageArr.count)
            var prefix = self.imageArr[0].prefix ?? ""
            var suffix = self.imageArr[0].suffix ?? ""
            self.titleImgURL = "\(prefix)original\(suffix)"
            self.ImageView.sd_setImage(with: URL(string:self.titleImgURL ), placeholderImage: UIImage(named: "placeholder"))

        }
        
       
        titlelabel.text = titlelbl
        Categorylbl.text = category
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            PhotosCon.isHidden = false
            InfoCon.isHidden = true
            PlacesCon.isHidden = true
            TipsCon.isHidden = true
        case 1:
            PhotosCon.isHidden = true
            InfoCon.isHidden = false
            PlacesCon.isHidden = true
            TipsCon.isHidden = true
        case 2:
            PhotosCon.isHidden = true
            InfoCon.isHidden = true
            PlacesCon.isHidden = false
            TipsCon.isHidden = true
        case 3:
            PhotosCon.isHidden = true
            InfoCon.isHidden = true
            PlacesCon.isHidden = true
            TipsCon.isHidden = false
        default:
            break
        }
    }
    
    
 
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
////        cell.layer.cornerRadius = 5
////        cell.layer.borderColor = UIColor.darkGray.cgColor
////        cell.layer.borderWidth = 2
////        return cell;
//    }
  
    
//    func addImageViewWithImage(image: UIImage) {
//
//        let imageView = UIImageView(frame: self.view.frame)
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor.black
//        imageView.image! = self.ImageView.image!
//        imageView.tag = 100
//
////        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(self.removeImage))
////        dismissTap.numberOfTapsRequired = 1
////        imageView.addGestureRecognizer(dismissTap)
//        self.view.addSubview(imageView)
//    }
//    func loadData(completed: @escaping([Images]) -> ()) -> Void{
//
//        let headers = [
//          "Accept": "application/json",
//          "Authorization": "fsq3KnLTCdMzGgbaxtU1+N42kB9gcOzgfQa8RKzChmcc67g="
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsqid)/photos")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//              if let myData = data {
//                  print(myData)
//                  if let json = try? JSONSerialization.jsonObject(with: myData, options: []) as? AnyObject{
//                      print(json)
//                          self.imageArr = self.parsePlaces(responseArr: json as! NSArray) as! [Images]
//                         print(self.imageArr.count)
//                      var prefix = self.imageArr[0].prefix ?? ""
//                      var suffix = self.imageArr[0].suffix ?? ""
//                      self.url = "\(prefix)original\(suffix)"
//                      print(self.url)
//                      self.ImageView.sd_setImage(with: URL(string: self.url ), placeholderImage: UIImage(named: "placeholder"))
//                       DispatchQueue.main.async {
//                           completed(self.imageArr)
//                      }
//
//
//                  }
//
//                  else {
//                      print("Error");
//                  }
//              }
//            //print(error)
//
//        })
//
//        dataTask.resume()
//}
//
//    //MARK: PARSING DATA INTO ARRAY
//     func parsePlaces(responseArr:NSArray) -> NSMutableArray
//       {
//           let placesArr:NSMutableArray = NSMutableArray()
//
//           for places in responseArr
//           {
//               if let placesDict = places as? NSDictionary
//               {
//                   let placesObj = Images(dictionary: placesDict)
//                   placesArr.add(placesObj!)
//               }
//           }
//
//           return placesArr
//       }
//
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photosegue" {
        let controller = segue.destination as! PhotosView
            controller.fsqid = fsqid
            
        }
        if segue.identifier == "tips" {
            let controller = segue.destination as! TipsView
            controller.fsqid = fsqid
            
        
    }
    }
}

