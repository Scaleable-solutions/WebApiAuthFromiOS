//
//  NameViewController.swift
//  WebAPIAuthFromiOS
//
//  Created by Hamza on 15/02/2016.
//  Copyright © 2016 Scaleable Solutions. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    
    var fullname:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.numberOfLines = 1
        NameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        NameLabel.text = fullname
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
