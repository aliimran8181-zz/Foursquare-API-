//
//  PlacesView.swift
//  Foursquare
//
//  Created by Ali on 08/12/2021.
//

import UIKit
import CoreLocation

class PlacesView: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var latitude = 0.0
    var longitude = 0.0
    var placeResultArr = [Results]()
    let apimanager = nearbyApiManager()
    let locationManager:CLLocationManager = CLLocationManager()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
              
               if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
                   locationManager.requestAlwaysAuthorization()
               }

               locationManager.startUpdatingLocation()
    }
    
    //MARK: TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print(foursquare.count)
        print(placeResultArr.count)
        return placeResultArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //   let row = foursquare[indexPath.row];
        let cell:nearbyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! nearbyTableViewCell
        
       // if let title = row["name"] as? String{
        cell.titleLabel.text = placeResultArr[indexPath.row].name
        
      //  }
      //  if let description = row["id"] as? String{
        cell.descriptionLabel.text = placeResultArr[indexPath.row].categories[0].name
            
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
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        tableView.rowHeight = 200
        return cell
        
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
            self.latitude = latitude
            self.longitude = longitude
            apimanager.loadData(longitude: self.longitude, latitude: self.latitude) { (results) in
                self.placeResultArr = results
                self.tableView.reloadData()
                self.tableView.delegate = self
                self.tableView.dataSource = self
            }
           // "print"("\(location.coordinate.latitude)" + "," + "\(location.coordinate.longitude)")
        }
    }

}
