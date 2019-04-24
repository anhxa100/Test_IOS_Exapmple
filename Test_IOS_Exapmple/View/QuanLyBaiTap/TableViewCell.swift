//
//  TableViewCell.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/9/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var weekNameLabel: UILabel!
    @IBOutlet weak var subjectIDLabel: UILabel!
    @IBOutlet weak var levelNameLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    
    @IBOutlet weak var weekNameLB: UILabel!
    @IBOutlet weak var subjectIDLB: UILabel!
    @IBOutlet weak var levelNameLB: UILabel!
    @IBOutlet weak var requirementLB: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
