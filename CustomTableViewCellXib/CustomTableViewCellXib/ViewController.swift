//
//  ViewController.swift
//  CustomTableViewCellXib
//
//  Created by Zhuolin Wang on 2023/2/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let imageNames = ["Rib", "Shrimp", "Steak", "Noodles", "Ramen", "Hotpot", "Fish", "Burger", "Hotdog", "Taco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
        
        cell.imageContainer.image = UIImage(named: imageNames[indexPath.row])
        cell.lblImage.text = imageNames[indexPath.row]
        
        return cell
    }
}

