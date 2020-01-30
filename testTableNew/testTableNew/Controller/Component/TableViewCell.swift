//
//  TableViewCell.swift
//  testTableNew
//
//  Created by chaikmon on 21/1/2563 BE.
//  Copyright © 2563 Advanced Research Group. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var labelProfile: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
