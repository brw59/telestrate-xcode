//
//  JoinManager.swift
//  Telestrate
//
//  Created by Benjamin Ray Walker on 1/24/17.
//  Copyright © 2017 Benjamin Ray Walker. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol JoinManagerDelegate {
    func updataLocalData(_ manager : JoinManager, dataArray: Data)
//    func sendData(_ manager : JoinManager, dataArray: Data)
}

class JoinManager : NSObject {
    var count: Int = 1
    
    fileprivate let myPeerId = MCPeerID(displayName: UIDevice.current.name) //MCPeerID.reusableInstance(withDisplayName: UIDevice.current.name)
    fileprivate var serviceBrowser : MCNearbyServiceBrowser
    var delegate : JoinManagerDelegate?
    
    override init() {
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: Settings.sharedInstance.serviceType)
        
        super.init()
        
        self.serviceBrowser.delegate = self
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    lazy var session: MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.required)
        session.delegate = self
        return session
    }()
    
    func sendData(_ data : Data) {
        if session.connectedPeers.count > 0 {
            do {
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                print("did not succeed in sending data")
            }
        }
    }
    
}

extension JoinManager : MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("\(self.myPeerId) Found and inviting peer \(peerID)");
        
        //                self.session.delegate = self; // what's this for?
        
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10);
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("didNotStartBrowsingForPeers")
    }
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("lostPeer: \(peerID)")
    }
    
}

extension JoinManager : MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("peer \(peerID) didChangeState: \(state.stringValue())")
//        self.delegate?.connectedDevicesChanged(self, connectedDevices: session.connectedPeers.map({$0.displayName}))
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("peer \(peerID) didReceiveData: \(data.count) bytes")
        self.delegate?.updataLocalData(self, dataArray: data)
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("peer \(peerID) didReceiveStream")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        print("peer \(peerID) didFinishReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("peer \(peerID) didStartReceivingResourceWithName")
    }
    
}
