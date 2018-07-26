//
//  InventoryListCell.swift
//  Motomez
//
//  Created by Sanzid iOS on 27/7/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//

import UIKit

class InventoryListCell: UITableViewCell {

    @IBOutlet weak var invoiceNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
