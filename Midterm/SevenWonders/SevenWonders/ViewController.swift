//
//  ViewController.swift
//  SevenWonders
//
//  Created by wzl on 2023/3/18.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let wonders = ["The Great Wall of China - Beijing, China", "Petra - Jordan", "Christ the Redeemer - Rio de Janeiro, Brazil", "Machu Picchu - Peru", "Chichen Itza - Mexico", "The Colosseum - Rome, Italy", "Taj Mahal - Agra, India"]
    
    let images = ["theGreatWall", "Petra", "ChristtheRedeemer", "MachuPicchu", "ChichenItza", "TheColosseum", "TajMahal"]
    
    let wonderDetails = ["The Great Wall of China is a series of fortifications made of stone, brick, tamped earth, wood, and other materials, generally built along an east-to-west line across the historical northern borders of China to protect the Chinese states and empires against the raids and invasions of the various nomadic groups of the Eurasian Steppe.","Petra is a historical and archaeological city in southern Jordan. The city is famous for its rock-cut architecture and water conduit system. Another name for Petra is the Rose City due to the color of the stone out of which it is carved.","Christ the Redeemer is an Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil, created by French sculptor Paul Landowski and built by Brazilian engineer Heitor da Silva Costa, in collaboration with French engineer Albert Caquot.","Machu Picchu is a 15th-century Inca citadel, located in the Eastern Cordillera of southern Peru, on a 2,430-metre (7,970 ft) mountain ridge. It is located in the Cusco Region, Urubamba Province, Machupicchu District, above the Sacred Valley, which is 80 kilometres (50 mi) northwest of Cuzco and through which the Urubamba River flows, cutting through the Cordillera and creating a canyon with a tropical mountain climate.","Chichen Itza is a complex of Mayan ruins on Mexico's Yucatán Peninsula. A massive step pyramid, known as El Castillo or Temple of Kukulcan, dominates the ancient city, which thrived from around 600 A.D. to the 1200s.","The Colosseum, also known as the Flavian Amphitheatre, is an oval amphitheatre in the centre of the city of Rome, Italy. Built of travertine, tuff, and brick-faced concrete, it is the largest amphitheatre ever built.","The Taj Mahal is an ivory-white marble mausoleum on the right bank of the Yamuna river in the Indian city of Agra. It was commissioned in 1632 by the Mughal emperor, Shah Jahan, to house the tomb of his favorite wife, Mumtaz Mahal."]
    
    var detailContent = ""
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self)?.first as! TableViewCell
        cell.imageContainer.image = UIImage(named: "\(images[indexPath.row])")
        cell.lblImage.text = wonders[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        detailContent = wonderDetails[indexPath.row]
        performSegue(withIdentifier: "segueDetailsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueDetailsVC" {
                let secondVC = segue.destination as! DetailsViewController
                secondVC.detail = detailContent
            }
    }
    
}

