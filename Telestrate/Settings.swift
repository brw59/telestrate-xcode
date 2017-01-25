//
//  Settings.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/24/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

class Settings {
    static let sharedInstance = Settings()
    var isHost = false
//    var playerOrder = [String]()
    var serviceType: String = "example-color"
    var deviceMap = [String]()
}
