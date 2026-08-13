//
//  TableViewCell.swift
//  newsApp
//
//  Created by enjay on 20/06/26.
//

import UIKit

class TabelViewCellSv: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var sourceLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    

}

