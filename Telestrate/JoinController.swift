//
//  JoinController.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/24/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import UIKit

class JoinController: UIViewController {
    
    @IBOutlet weak var peerListLb: UILabel!
    @IBOutlet weak var isHostLb: UILabel!
    
    let connectionService = JoinManager()
    
    @IBAction func backBtnAct(_ sender: UIButton) {
        print("Back button pressed from JoinController 👍")
        self.performSegue(withIdentifier: "unwindToMainMenuFromJoin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupInitialTitles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupInitialTitles() {
        isHostLb.text = "this is not the host"
        isHostLb.numberOfLines = 0
        peerListLb.text = "Connections:"
        peerListLb.numberOfLines = 0
    }
    
    @IBAction func sendSomething(_ sender: UIButton) {
        print("something is being sent")
        connectionService.sendData(StringArrayToNSData(deviceNames: Settings.sharedInstance.deviceMap) as Data)
    }
    
    func updateDeviceDisplayList() {
        let tempStringArray = Settings.sharedInstance.deviceMap
        if tempStringArray.count > 0 {
            var tempText = ""
            for i in 0..<tempStringArray.count {
                tempText += tempStringArray[i]
                if i != tempStringArray.count - 1 {
                    tempText += ", "
                }
            }
            peerListLb.text = tempText
        } else {
            peerListLb.text = "There is not a device"
        }
    }
}

extension JoinController : JoinManagerDelegate {
    func updataLocalData(_ manager : JoinManager, dataArray: Data) {
        
        var stringArray = self.NSDataToStringArray(data: dataArray as NSData)
        
        if stringArray[0] == "orderUpdate" {
            Settings.sharedInstance.deviceMap = []
            for i in 1..<stringArray.count {
                Settings.sharedInstance.deviceMap += [stringArray[i]]
            }
            OperationQueue.main.addOperation { () -> Void in
                self.peerListLb.text = "Connections: \(Settings.sharedInstance.deviceMap)"
            }
        }
    }
}

extension JoinController {
    func NSDataToStringArray(data: NSData) -> [String] {
        var decodedStrings = [String]()
        
        var stringTerminatorPositions = [Int]()
        
        var currentPosition = 0
        data.enumerateBytes() {
            buffer, range, stop in
            
            let bytes: UnsafePointer = buffer.assumingMemoryBound(to: UInt8.self)
            for i in 0 ..< range.length {
                if bytes[i] == 0 {
                    stringTerminatorPositions.append(currentPosition)
                }
                currentPosition += 1
            }
        }
        
        var stringStartPosition = 0
        for stringTerminatorPosition in stringTerminatorPositions {
            let encodedString = data.subdata(with: NSMakeRange(stringStartPosition, stringTerminatorPosition - stringStartPosition))
            let decodedString =  NSString(data: encodedString, encoding: String.Encoding.utf8.rawValue) as! String
            decodedStrings.append(decodedString)
            stringStartPosition = stringTerminatorPosition + 1
        }
        
        return decodedStrings
    }
    
    func StringArrayToNSData(deviceNames: [String]) -> NSData {
        let data = NSMutableData()
        let terminator = [0]
        
        let encodedString = "orderUpdate".data(using: String.Encoding.utf8)
        data.append(encodedString!)
        data.append(terminator, length: 1)
        for name in deviceNames {
            if let encodedString = name.data(using: String.Encoding.utf8) {
                data.append(encodedString)
                data.append(terminator, length: 1)
            }
            else {
                NSLog("Cannot encode string \"\(name)\"")
            }
        }
        
        return data
    }
}
