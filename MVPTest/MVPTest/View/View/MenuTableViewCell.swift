//
//  MenuTableViewCell.swift
//  MVPTest
//
//  Created by sa on 2/20/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imvBkg: UIImageView!
    @IBOutlet weak var imvIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imvCircle: UIImageView!
    @IBOutlet weak var lblNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
