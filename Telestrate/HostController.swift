//
//  HostController.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/24/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import UIKit

class HostController: UIViewController {
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        print("Back button pressed from HostController 👍")
        self.performSegue(withIdentifier: "unwindToMainMenuFromHost", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

