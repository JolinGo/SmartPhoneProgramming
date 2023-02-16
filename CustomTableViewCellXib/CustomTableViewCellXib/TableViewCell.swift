//
//  TableViewCell.swift
//  CustomTableViewCellXib
//
//  Created by Zhuolin Wang on 2023/2/16.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageContainer: UIImageView!
    
    @IBOutlet weak var lblImage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
