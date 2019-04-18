//
//  MainMacrosTableViewCell.swift
//  STUDIO_Project
//
//  Created by Israel Quinonez on 4/16/19.
//  Copyright © 2019 Israel Quinonez. All rights reserved.
//

import UIKit

class MainMacrosTableViewCell: UITableViewCell {

   // @IBOutlet weak var mainMacroCellImaeg: UIImageView!
    @IBOutlet weak var macroNameLabelCell: UILabel!
    @IBOutlet weak var maroValueLabelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
