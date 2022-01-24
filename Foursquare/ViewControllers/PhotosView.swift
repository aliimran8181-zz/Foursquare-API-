//
//  PhotosView.swift
//  Foursquare
//
//  Created by Ali on 08/12/2021.
//

import UIKit

class PhotosView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let places = placeDetailVC()
    var imageArr = [Images]()
    var fsqid = ""
    var titlelbl = ""
    var category = ""
    var perfix = ""
    var suffix = ""
    var titleImgURL = ""
    var collectionImgURL = ""
    let apimanager = ApiManager()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places.fsqid = fsqid
        //print(fsqid)
        apimanager.loadData(fsqid: fsqid) { (results) in
            self.imageArr = results
           // print(self.imageArr.count)
       //     self.setUi()
            self.collectionView.dataSource = self
            self.collectionView.reloadData()
            self.collectionView.delegate = self
    }
}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(imageArr.count)
       return imageArr.count
       
              
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let row = imageArr[indexPath.row];
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        var prefixs = self.imageArr[indexPath.row].prefix ?? ""
        var suffixs = self.imageArr[indexPath.row].suffix ?? ""
        self.collectionImgURL = "\(prefixs)original\(suffixs)"
       // print(collectionImgURL)
        cell.ImgView.sd_setImage(with: URL(string: collectionImgURL  ), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
//    func setUi(){
//        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
//        layout.minimumInteritemSpacing = 5
//        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 20)/3, height: (self.collectionView.frame.size.height)/3)
//    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
            layout.minimumInteritemSpacing = 5
            return CGSize(width: (self.collectionView.frame.size.width - 20)/2 , height:(self.collectionView.frame.size.height - 20)/2)
        }
   
    
}
