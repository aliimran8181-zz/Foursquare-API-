//
//  ViewController.swift
//  Foursquare
//
//  Created by Ali on 24/11/2021.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    var searchbarText = ""
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    
    @IBAction func breakfast(_ sender: UIButton) {
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        nextViewController.selectedCategory = "Breakfast"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.selectedCategoryID = "&categories=13028"
        }
    
    @IBAction func Lunch(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        nextViewController.selectedCategory = "Lunch"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.selectedCategoryID = "&categories=13065"
    }
    
    @IBAction func Dinner(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        nextViewController.selectedCategory = "Dinner"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.selectedCategoryID = "&categories=13065"
   
    }
    
    @IBAction func Cofee(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        nextViewController.selectedCategory = "Cofee & Tea"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.selectedCategoryID = "&categories=13032"
   
    }
    @IBAction func Night(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        nextViewController.selectedCategory = "Night Life"
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.selectedCategoryID = "&categories=10032"
    }
    @IBAction func Things(_ sender: Any) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        nextViewController.selectedCategory = "Things to do"
        nextViewController.selectedCategoryID = "&categories=10000"
        self.navigationController?.pushViewController(nextViewController, animated: true)
  
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "breakfast") as! PlacesVC
        searchbarText =  "query=\(searchBar.text!)&"
        //print(searchbarText)
        nextViewController.search = searchbarText
        nextViewController.selectedCategory = searchBar.text!
        self.navigationController?.pushViewController(nextViewController, animated: true)
        nextViewController.selectedCategoryID = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
    
    }
    
}
