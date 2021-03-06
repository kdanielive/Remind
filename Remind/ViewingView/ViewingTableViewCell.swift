//
//  ViewingTableViewCell.swift
//  Remind
//
//  Created by Daniel Kim on 2/1/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import UIKit

class ViewingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for subview in self.subviews {
            subview.isHidden = true
        }
    }

}
