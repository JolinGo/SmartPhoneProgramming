//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Zhuolin Wang on 2023/2/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let resturants = ["Panda Express", "Taco Bell", "McDonald's", "KFC", "Seattle Seafood"]
    let food = [
        ["Fried Rice","Noodles","Orange Chicken","Mushroom Chicken","Grilled Beef","Ramen"],
        ["Brown Rice","Steak Tacos","Chicken Tacos","Beef Tougue Tacos","Fish Chip Tacos"],
        ["Big Mac","McChicken","French Fries","Apple Pie","McFlurry","Burger","McNuggets"],
        ["Original Recipe Chicken","Extra Crispy Chicken","Burger","Potato Wedges","Mashed Potatoes","Biscuits","Fries"],
        ["Grilled Fish","Baked Oyster","Sweet Shrimp","Grilled Crab","Baked Salmon"],
    ]
    
    var selectedResturantIndex = 0
    
    @IBOutlet weak var tblViewTop: UITableView!
    @IBOutlet weak var tblViewBottom: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewTop.delegate = self
        tblViewTop.dataSource = self
        tblViewBottom.delegate = self
        tblViewBottom.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewTop {
            return resturants.count
        } else {
            return food[selectedResturantIndex].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewTop {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = resturants[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = food[selectedResturantIndex][indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblViewTop {
            selectedResturantIndex = indexPath.row
            tblViewBottom.reloadData()
        }
    }

}

