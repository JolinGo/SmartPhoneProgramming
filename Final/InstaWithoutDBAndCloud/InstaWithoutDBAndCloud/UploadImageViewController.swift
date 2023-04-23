//
//  UploadImageViewController.swift
//  InstaWithoutDBAndCloud
//
//  Created by wzl on 2023/4/22.
//

import UIKit
import CoreLocation
import RealmSwift

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    let realm = try! Realm()
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtTitlt: UITextField!
    @IBOutlet weak var lblLocation: UILabel!
    
    var uploadProtocol: UploadImageProtocol?
    
    //Get current location
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
        
    }
    
    @IBAction func takeAPictureAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Take a picture", message: "Get a picture", preferredStyle: .alert)
                
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default){ action in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true)
            }
        }
                
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){ action in
            print("Cancel")
        }
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imgView.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    //Get the location and address
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
//        let lat = location.coordinate.latitude
//        let lng = location.coordinate.longitude
        
        getAddressFromLocation(location: location)
    }
        
    func getAddressFromLocation(location: CLLocation){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            
            if error != nil {
                print(error)
                return
            }
            
            var address = ""
            guard let place = placemarks?.first else {return}
            if place.name != nil {
                address += place.name! + ", "
            }
            if place.subLocality != nil {
                address += place.subLocality! + ", "
            }
            if place.locality != nil {
                address += place.locality! + ", "
            }
            if place.postalCode != nil {
                address += place.postalCode! + " "
            }
            
            //print(address)
            self.lblLocation.text = address
        }
        
    }

    
    @IBAction func uploadAction(_ sender: Any) {
        
        guard let img = imgView.image else {return}
        guard let location = lblLocation.text else {return}
        guard let title = txtTitlt.text else {return}
        
        uploadProtocol?.uploadImageProtocol(img: img, locationImg: location, titleImg: title)
        
        //add image to the local DB
        addDataToDB()

        //return to home tab
        self.tabBarController?.selectedIndex = 0
    }
    
    //add image to local DB
    func addDataToDB() {
        
        let currentImage: ImageInfo = ImageInfo()
        guard let img = imgView.image else {return}
        guard let location = lblLocation.text else {return}
        guard let title = txtTitlt.text else {return}
        
        let imageData = img.jpegData(compressionQuality: 0.5)
        currentImage.image = imageData
        
        currentImage.location = location
        currentImage.title = title
        
        do {
            try! realm.write {
                realm.add(currentImage, update: .modified)
            }
        } catch let error as NSError {
            print("Unable to add values to the DB")
        }
    }

    
}
