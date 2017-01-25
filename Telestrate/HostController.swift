//
//  HostController.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/24/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import UIKit
//import MultipeerConnectivity

class HostController: UIViewController {
    
    @IBOutlet weak var isHostLb: UILabel!
    @IBOutlet weak var deviceListLb: UILabel!
    let communicationService = HostManager()
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        print("Back button pressed from HostController 👍")
        self.performSegue(withIdentifier: "unwindToMainMenuFromHost", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupBtns()
    }
    
    
    func setupBtns() {
        isHostLb.numberOfLines = 0
        deviceListLb.numberOfLines = 0
        
        if Settings.sharedInstance.isHost {
            isHostLb.text = "This device is the Host"
        } else {
            isHostLb.text = "This device is not the Host"
        }
        updateDeviceDisplayList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            deviceListLb.text = tempText
        } else {
            deviceListLb.text = "There is not a device"
        }
    }
}


extension HostController : HostManagerDelegate {
    func connectedDevicesChanged(_ manager: HostManager, connectedDevices: [String]) {

        Settings.sharedInstance.deviceMap = connectedDevices
        var newStringArray: [String] = []
        newStringArray += ["orderUpdate"]
        for item in connectedDevices {
            newStringArray += [item]
        }
        
        OperationQueue.main.addOperation { () -> Void in
            self.deviceListLb.text = "Connections: \(connectedDevices)"
            self.communicationService.sendData(self.StringArrayToNSData(deviceNames: newStringArray) as Data)
            
        }
    }
}
extension HostController {
    func updataLocalData(_ manager : HostManager, dataArray: Data) {
        let strArray = NSDataToStringArray(data: dataArray as NSData)
        
        if strArray[0] == "orderUpdate" {
            Settings.sharedInstance.deviceMap = []
            for i in 1..<strArray.count {
                Settings.sharedInstance.deviceMap += [strArray[i]]
            }
            print(Settings.sharedInstance.deviceMap)
        }
        self.updateDeviceDisplayList()
    }
    
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
