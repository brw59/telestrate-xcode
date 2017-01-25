//
//  ViewController.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/21/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import UIKit

class MainMenuController: UIViewController {

    @IBAction func unwindToMainMenu(_ segue: UIStoryboardSegue) {
        print("Did Unwind to Main Menu")
    }
    
    @IBAction func hostBtnAct(_ sender: UIButton) {
        Settings.sharedInstance.isHost = true
    }
    
    @IBAction func joinBtnAct(_ sender: UIButton) {
        Settings.sharedInstance.isHost = false
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

