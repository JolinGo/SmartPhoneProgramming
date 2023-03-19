//
//  ViewController.swift
//  MakeAPICall
//
//  Created by wzl on 2023/3/18.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var txtStockSymbol: UITextField!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    let apiKey = "84a1cef92580f013998f75241bbb805c"
    let baseURL = "https://financialmodelingprep.com/api/v3/profile/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getCompanyProfile(_ sender: Any) {
        guard let symbol = txtStockSymbol.text else {return}
                
                let url = "\(baseURL)\(symbol)?apikey=\(apiKey)"
                
                SwiftSpinner.show("Getting Company Profile for \(symbol)")
                
                Alamofire.request(url).responseJSON { response in
                    SwiftSpinner.hide()
                    if response.error != nil {
                        print("Error in response")
                        return
                    }
                    guard let rawData = response.data else {return}
                    guard let jsonArray = JSON(rawData).array else {return}
                    guard let stock = jsonArray.first else {return}
                    let name = stock["companyName"].stringValue
                    let price = stock["price"].doubleValue
                    let website = stock["website"].stringValue
                    
                    self.lblName.text = "CompanyName: \(name)"
                    self.lblPrice.text = "Price: \(price)"
                    self.lblWebsite.text = "Website: \(website)"

                }
    }

}

