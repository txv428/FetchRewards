//
//  TableViewCell.swift
//  FetchRewards
//
//  Created by tejasree vangapalli on 3/5/20.
//  Copyright © 2020 tejasree vangapalli. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var text1: UILabel!
    
    @IBOutlet weak var text2: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
