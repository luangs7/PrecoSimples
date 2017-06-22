//
//  BaseViewCell.swift
//  PrecoSimples
//
//  Created by Luan Silva on 22/06/17.
//  Copyright © 2017 Squarebits. All rights reserved.
//

import UIKit

class BaseViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
