//
//  DetailsViewController.swift
//  SevenWonders
//
//  Created by wzl on 2023/3/18.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblDetails: UILabel!
    
    var detail = "Detail: "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDetails.text = "\(detail)"
    }

}
