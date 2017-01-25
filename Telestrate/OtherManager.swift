//
//  OtherManager.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/25/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import Foundation
import MultipeerConnectivity

extension MCSessionState {
    
    func stringValue() -> String {
        switch(self) {
        case .notConnected: return "NotConnected"
        case .connecting: return "Connecting"
        case .connected: return "Connected"
        default: return "Unknown"
        }
    }
    
}
