////
////  HostController.swift
////  Telestrate
////
////  Created by Benjamin Ray Walker on 1/24/17.
////  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
////
//
//import UIKit
////import MultipeerConnectivity
//
//class HostController: UIViewController {
//    
//    var deviceMap = [String]()
//    
//    @IBOutlet weak var isHostLb: UILabel!
//    @IBOutlet weak var deviceListLb: UILabel!
//    let communicationService = ConnectionServiceManager()
//    
//    @IBAction func backBtnAction(_ sender: UIButton) {
//        print("Back button pressed from HostController 👍")
//        self.performSegue(withIdentifier: "unwindToMainMenuFromHost", sender: self)
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        setupBtns()
//    }
//    
//    
//    func setupBtns() {
//        isHostLb.numberOfLines = 0
//        deviceListLb.numberOfLines = 0
//        
//        if Settings.sharedInstance.isHost {
//            isHostLb.text = "This device is the Host"
//        } else {
//            isHostLb.text = "This device is not the Host"
//        }
//        updateDeviceDisplayList()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func updateDeviceDisplayList() {
//        if deviceMap.count > 0 {
//            var tempText = ""
//            for i in 0..<deviceMap.count {
//                tempText += deviceMap[i]
//                if i != deviceMap.count - 1 {
//                    tempText += ", "
//                }
//            }
//            deviceListLb.text = tempText
//        } else {
//            deviceListLb.text = "There is not a device"
//        }
//    }
//}
//
//
//extension HostController : ConnectionManagerDelegate {
//    func connectedDevicesChanged(_ manager: ConnectionServiceManager, connectedDevices: [String]) {
//        OperationQueue.main.addOperation { () -> Void in
//            self.deviceListLb.text = "Connections: \(connectedDevices)"
//            
//            //            self.deviceMap = []
//            //            print("Connected Devices changed")
//            //            self.deviceMap += [UIDevice.current.name]
//            //            for name in connectedDevices {
//            //                self.deviceMap += [name]
//            //
//            //                print(String(describing: MCPeerID(displayName: name)))
//            //            }
//            //
//            //
//            //
//            //            self.updateDeviceDisplayList()
//            //            self.communicationService.sendPlayerOrder(self.StringArrayToNSData(deviceNames: self.deviceMap) as Data)
//            
//        }
//    }
//    
//    //    func orderChanged(_ manager : ConnectionServiceManager, orderIndex: Int)
//    //    {
//    ////        OperationQueue.main.addOperation { () -> Void in
//    ////            for item in self.deviceMap {
//    ////                if (item as! Array)[2] != orderIndex {
//    ////
//    ////                }
//    ////            }
//    ////        }
//    ////        deviceMap.
//    //    }
//    
//    func updataLocalData(_ manager : ConnectionServiceManager, dataArray: Data) {
//        //        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
//        let strArray = NSDataToStringArray(data: dataArray as NSData)
//        
//        if strArray[0] == "orderUpdate" {
//            deviceMap = []
//            for i in 1..<strArray.count {
//                deviceMap += [strArray[i]]
//            }
//            print(deviceMap)
//        }
//        self.updateDeviceDisplayList()
//    }
//    
//    func NSDataToStringArray(data: NSData) -> [String] {
//        var decodedStrings = [String]()
//        
//        var stringTerminatorPositions = [Int]()
//        
//        var currentPosition = 0
//        data.enumerateBytes() {
//            buffer, range, stop in
//            
//            let bytes: UnsafePointer = buffer.assumingMemoryBound(to: UInt8.self)
//            for i in 0 ..< range.length {
//                if bytes[i] == 0 {
//                    stringTerminatorPositions.append(currentPosition)
//                }
//                currentPosition += 1
//            }
//        }
//        
//        var stringStartPosition = 0
//        for stringTerminatorPosition in stringTerminatorPositions {
//            let encodedString = data.subdata(with: NSMakeRange(stringStartPosition, stringTerminatorPosition - stringStartPosition))
//            let decodedString =  NSString(data: encodedString, encoding: String.Encoding.utf8.rawValue) as! String
//            decodedStrings.append(decodedString)
//            stringStartPosition = stringTerminatorPosition + 1
//        }
//        
//        return decodedStrings
//    }
//    
//    
//    func StringArrayToNSData(deviceNames: [String]) -> NSData {
//        let data = NSMutableData()
//        let terminator = [0]
//        
//        let encodedString = "orderUpdate".data(using: String.Encoding.utf8)
//        data.append(encodedString!)
//        data.append(terminator, length: 1)
//        for name in deviceNames {
//            if let encodedString = name.data(using: String.Encoding.utf8) {
//                data.append(encodedString)
//                data.append(terminator, length: 1)
//            }
//            else {
//                NSLog("Cannot encode string \"\(name)\"")
//            }
//        }
//        
//        //        var peerId: MCPeerID = {
//        //            let defaults = UserDefaults.standard;
//        //            let dataToShow = defaults.data(forKey: "kLocalPeerIDKey");
//        //            var peer = NSKeyedUnarchiver.unarchiveObject(with: dataToShow!) as? MCPeerID;
//        //            if peer == nil {
//        //                peer = MCPeerID(displayName: UIDevice.current.name);
//        //                let data: NSData = NSKeyedArchiver.archivedData(withRootObject: peer!) as NSData;
//        //                defaults.set(data, forKey: "kPeerID");
//        //                defaults.synchronize();
//        //            }
//        //            print("I am peer: \(peer!)");
//        //            return peer!;
//        //        }()
//        
//        
//        return data
//    }
//}
