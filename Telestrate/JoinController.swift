//
//  JoinController.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/24/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import UIKit

class JoinController: UIViewController {
    
    @IBAction func backBtnAct(_ sender: UIButton) {
        print("Back button pressed from JoinController 👍")
        self.performSegue(withIdentifier: "unwindToMainMenuFromJoin", sender: self)
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
