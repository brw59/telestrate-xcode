////
////  ConnectionManager.swift
////  Telestrate
////
////  Created by Benjamin Ray Walker on 1/24/17.
////  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
////
//
//import Foundation
//import MultipeerConnectivity
//
//protocol ConnectionManagerDelegate {
//    
//    func connectedDevicesChanged(_ manager : ConnectionServiceManager, connectedDevices: [String])
////    func orderChanged(_ manager : ConnectionServiceManager, orderIndex: Int)
//    func updataLocalData(_ manager : ConnectionServiceManager, dataArray: Data)
//}
//
//class ConnectionServiceManager : NSObject {
//    
//    var deviceNumber: Int = 0
//    
//    fileprivate let TelestrateServiceType = "example-color"
//    fileprivate let myPeerId = MCPeerID(displayName: UIDevice.current.name) //MCPeerID.reusableInstance(withDisplayName: UIDevice.current.name)
//    fileprivate let serviceAdvertiser : MCNearbyServiceAdvertiser
//    fileprivate let serviceBrowser : MCNearbyServiceBrowser
//    var delegate : ConnectionManagerDelegate?
//    
//    override init() {
//        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: TelestrateServiceType)
//        
//        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: TelestrateServiceType)
//        
//        super.init()
//        
//        self.serviceAdvertiser.delegate = self
//        self.serviceAdvertiser.startAdvertisingPeer()
//        
//        self.serviceBrowser.delegate = self
//        self.serviceBrowser.startBrowsingForPeers()
//    }
//    
//    deinit {
//        self.serviceAdvertiser.stopAdvertisingPeer()
//        self.serviceBrowser.stopBrowsingForPeers()
//    }
//    
//    lazy var session: MCSession = {
//        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.required)
//        session.delegate = self
//        return session
//    }()
//    
//    func sendPlayerOrder(_ orderArrayData: Data) {
//        print("sending player order")
//        
//        if session.connectedPeers.count > 0 {
//            do {
//                try session.send(orderArrayData, toPeers: session.connectedPeers, with: MCSessionSendDataMode.reliable)
//            } catch {
//                print("broken")
//            }
//        }
//    }
//    
//}
//
//extension ConnectionServiceManager : MCNearbyServiceAdvertiserDelegate {
//    
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
//        print("didNotStartAdvertisingPeer")
//    }
//    
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping ((Bool, MCSession?) -> Void)) {
//        
//        print("didReceiveInvitationFromPeer \(peerID)")
//        print("\(self.myPeerId) Received Invitation from \(peerID)");
//        // want to display a list of potential sessions to join for the user here
//        invitationHandler(true, self.session)
//    }
//    
//}
//
//extension ConnectionServiceManager : MCNearbyServiceBrowserDelegate {
//    
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        print("\(self.myPeerId) Found peer \(peerID)");
//        
//       
////        self.session.delegate = self; // what's this for?
//        print("invite peer: \(peerID)")
//        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10);
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        print("didNotStartBrowsingForPeers")
//    }
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        print("lostPeer: \(peerID)")
//    }
//    
//}
//
//extension MCSessionState {
//    func stringValue() -> String {
//        switch(self) {
//        case .notConnected: return "NotConnected"
//        case .connecting: return "Connecting"
//        case .connected: return "Connected"
//        default: return "Unknown"
//        }
//    }
//}
//
//extension ConnectionServiceManager : MCSessionDelegate {
//    
//    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        print("peer \(peerID) didChangeState: \(state.stringValue())")
////        if peerID == myPeerId {
//        self.delegate?.connectedDevicesChanged(self, connectedDevices: session.connectedPeers.map({$0.displayName}))
////        }
//    }
//    
//    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        print("peer \(peerID) didReceiveData: \(data.count) bytes")
////        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
////        self.delegate?.colorChanged(self, colorString: str)
////        self.delegate?.orderChanged(self, orderIndex: <#T##Int#>)
//        self.delegate?.updataLocalData(self, dataArray: data)
//        
//    }
//
//    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
//        print("peer \(peerID) didReceiveStream")
//    }
//    
//    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
//        print("peer \(peerID) didFinishReceivingResourceWithName")
//    }
//    
//    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
//        print("peer \(peerID) didStartReceivingResourceWithName")
//    }
//    
//}
//
