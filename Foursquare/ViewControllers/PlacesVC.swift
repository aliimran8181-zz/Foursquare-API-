//
//  breakfastLunchVC.swift
//  Foursquare
//
//  Created by Ali on 26/11/2021.
//

import UIKit
import CoreLocation
import SDWebImage
import SkeletonView
class PlacesVC: UIViewController, CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    
    
    //MARK: Variables
  //  var foursquare: Array<Dictionary<String,Any>> = []
    
    var apiLocation: String!
    var Latitude = 0.0
    var Logitude = 0.0
    let locationManager:CLLocationManager = CLLocationManager()
    var placeResultArr = [Results]()
    var selectedCategory = ""
    var selectedCategoryID = ""
    var fsqid = ""
    var search = ""
    var Searchbar = ""
    //MARK: IBOutlets
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
  
    
    
    @IBAction func SearchButton(_ sender: Any) {
      
    }
    
   //var imageArray = [UIImage]()
 //   var placesModel : PlacesModel?
    
    //MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.text = selectedCategory
        tableView.dataSource = self
        tableView.delegate = self
        indicatorviewstart()
        //searchBar.text = selectedCategory
       
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
              
               if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
                   locationManager.requestAlwaysAuthorization()
               }

               locationManager.startUpdatingLocation()
       
       
     
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == ""){
            search = ""
           // viewDidLoad()
            loadData()
            self.tableView.reloadData()
        }
        else {
         //   Searchbar = searchBar.text ?? ""
            search = "query=\(searchBar.text!)&"
         //   print(search)
          //  viewDidLoad()
            loadData()
            self.tableView.reloadData()
        }
    }
      
    
    //MARK: DATA LOADING FROM API & API AUTHENTICATION For location
    func loadData(){
        let headers = [
          "Accept": "application/json",
          "Authorization": "fsq3KnLTCdMzGgbaxtU1+N42kB9gcOzgfQa8RKzChmcc67g="
        ]

       // print(Latitude)
       // print(Logitude)
        print(search)
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/search?\(search)ll=\(Latitude)%2C\(Logitude)&radius=5000\(selectedCategoryID)&limit=50")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        print(request)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let myData = data {
               // print(myData)
                if let json = try? JSONSerialization.jsonObject(with: myData, options: []) as? NSDictionary {
                //  print(json)
                    if let dataRes = json.object(forKey: "results") as? NSArray
                    {
                     //   print(dataRes)
                        
                        self.placeResultArr = self.parsePlaces(responseArr: dataRes) as! [Results]
                      //  print(self.placeResultArr.count)
                        DispatchQueue.main.async {
                           
                            self.tableView.reloadData()
                            self.indicatorviewstop()
                        }
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
    
    
    //MARK: TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(foursquare.count)
        return placeResultArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //   let row = foursquare[indexPath.row];
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
       // if let title = row["name"] as? String{
        cell.titlelbl.text = placeResultArr[indexPath.row].name
        
      //  }
      //  if let description = row["id"] as? String{
        cell.lb2.text = placeResultArr[indexPath.row].categories[0].name
            
      //  }
      //  if let urlToImage = row["icon"] as? String{
      
        
        cell.imgView.sd_setImage(with: URL(string: (placeResultArr[indexPath.row].categories[0].icon?.prefix)! + "120.png"), placeholderImage: UIImage(named: "placeholder"))
        //print( )
       // cell.imgView.sd_setImage(with: URL(string: ImageResultArr[indexPath.row].prefix ?? ""))
//       print(ImageResultArr[indexPath.row].prefix ?? "")
        //print(placeResultArr[indexPath.row].categories[0].icon?.prefix ?? "" + (placeResultArr[indexPath.row].categories[0].icon?.suffix)!)
        
       // fsqid = placeResultArr[indexPath.row].fsq_id ?? ""
        //let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlaceDetail") as! placeDetailVC
       // nextViewController.fsqid = fsqid
 
        
//           }
       // print(placeResultArr[indexPath.row].categories[0].icon?.prefix ?? ""\(".png"))
        cell.lbl3.text = placeResultArr[indexPath.row].categories[0].name
        cell.lb2.text = placeResultArr[indexPath.row].timezone
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        tableView.rowHeight = 200
        return cell
        
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
     // self.addImageViewWithImage(image: cell.imgView.image)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlaceDetail") as! placeDetailVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.fsqid = placeResultArr[indexPath.row].fsq_id!
        nextViewController.category =  placeResultArr[indexPath.row].categories[0].name!
        nextViewController.titlelbl =  placeResultArr[indexPath.row].name!

    }
    
    //MARK: INDICATOR VIEW FUNCTIONS
    func indicatorviewstart(){
        self.ActivityIndicator.startAnimating()
        self.ActivityIndicator.isHidden = false
        self.tableView.alpha = 0
    }
    func indicatorviewstop(){
        self.ActivityIndicator.stopAnimating()
        self.ActivityIndicator.isHidden = true
        self.tableView.alpha = 1
        
    }
    
    
    // MARK: CURRENT LOCATION GET FUNCTIONS
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        // Handle changes if location permissions
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
        //    print (latitude)
            self.Latitude = latitude
            self.Logitude = longitude
            self.loadData()
           // "print"("\(location.coordinate.latitude)" + "," + "\(location.coordinate.longitude)")
        }
    }
  
    
}
