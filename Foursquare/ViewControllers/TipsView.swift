//
//  TipsView.swift
//  Foursquare
//
//  Created by Ali on 08/12/2021.
//

import UIKit

class TipsView: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
  
    
    var fsqid = ""
    var tipsArr = [tips]()
    var apimanager = tipsAPIManager()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
      
        apimanager.loadData(fsqid: fsqid) { (results) in
            print(self.fsqid)
            self.tipsArr = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
           }
            
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:tipsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tipscell", for: indexPath) as! tipsTableViewCell
      //  print(tipsArr[indexPath.row].text)
        cell.lblView.text = tipsArr[indexPath.row].text
        return cell
    }
}
