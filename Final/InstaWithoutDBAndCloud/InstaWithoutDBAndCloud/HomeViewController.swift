//
//  HomeViewController.swift
//  InstaWithoutDBAndCloud
//
//  Created by wzl on 2023/4/22.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UploadImageProtocol {
    
    let realm = try! Realm()
    
    var images : [UIImage] = [UIImage]()
    var locations = [String]()
    var imageTitles = [String]()
    
    @IBOutlet weak var tblView: UITableView!
    var uploadImageVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let controller = navigationController?.tabBarController
        uploadImageVC = navigationController?.tabBarController?.viewControllers?[0]
        
        //get image data from local DB
        getDataFromDB()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("HomeTableViewCell", owner: self)?.first as! HomeTableViewCell
                
        cell.imageContainer.image = images[indexPath.row]
        cell.lblImageTitle.text = imageTitles[indexPath.row]
        cell.lblImageLocation.text = locations[indexPath.row]
        
        return cell
    }
    
    func uploadImageProtocol(img: UIImage, locationImg: String, titleImg: String) {
        images.append(img)
        locations.append(locationImg)
        imageTitles.append(titleImg)
        
        tblView.reloadData()
    }
    
    //get data from the local DB
    func getDataFromDB() {
        
        let imageData = realm.objects(ImageInfo.self)
        for imgItem in imageData {
            
            if let img = imgItem.image {
                if let image = UIImage(data: img) {
                    images.append(image)
                }
            }
            locations.append(imgItem.location)
            imageTitles.append(imgItem.title)
        }
        tblView.reloadData()
    }

}
