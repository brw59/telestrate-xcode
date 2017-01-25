////
////  Tools.swift
////  Telestrate
////
////  Created by Benjamin Ray Walker on 1/25/17.
////  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class Tools : NSObject {
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
//        return data
//    }
//}
