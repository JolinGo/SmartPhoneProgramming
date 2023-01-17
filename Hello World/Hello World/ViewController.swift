//
//  ViewController.swift
//  Hello World
//
//  Created by wzl on 17/01/2023.
//  Copyright © 2023 Zhuolin Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblExample: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("I am inside viewDidLoad() function!");
    }

    @IBAction func pressMeAction(_ sender: UIButton) {
        print("Button was pressed");
        lblExample.text = "Hello World"
    }


}

