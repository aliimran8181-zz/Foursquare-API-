//
//  TableViewCell.swift
//  Foursquare
//
//  Created by Ali on 29/11/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
