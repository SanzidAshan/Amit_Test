//
//  InventoryTableView.swift
//  Motomez
//
//  Created by Maze Geek on 7/12/18.
//  Copyright © 2018 Amit Biswas. All rights reserved.
//// last modify - 07/16 - 5 PM

import UIKit

class InventoryTableViewCell: UITableViewCell {
    
    
    //Outlets
    @IBOutlet weak var partnumberLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Swt button image from assets
        plusButton.setImage(UIImage(named: "plus_Count"), for: .normal)
        minusButton.setImage(UIImage(named: "minus_Count"), for: .normal)
        
        //Product id label line break
        partnumberLabel.numberOfLines = 0
        partnumberLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
