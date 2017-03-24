//
//  ViewController.swift
//  BeaconNanoChallenge
//
//  Created by Gabriela de Carvalho Barros Bezerra on 23/03/17.
//  Copyright © 2017 Gabriela Bezerra. All rights reserved.
//

import UIKit
import CoreLocation
import MultipeerConnectivity

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Bacon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeacons(in: region)
        
        
        // Multipeer
        let browser = MCNearbyServiceBrowser.init(peer: peerID, serviceType: serviceType)
        browser.delegate = self
        
        let advertiser = MCNearbyServiceAdvertiser.init(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        advertiser.delegate = self

        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("beacon ranged")
        let immediateBeacons = beacons.filter{ $0.proximity == CLProximity.immediate }
        let nearBeacons      = beacons.filter{ $0.proximity == CLProximity.near }
        
        
        if((immediateBeacons.count + nearBeacons.count) >= 3){
            
        }
    }
    
    //Checking all beacons and printing to console
    /*func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        let immediateBeacons    = beacons.filter{ $0.proximity == CLProximity.immediate}
        let nearBeacons         = beacons.filter{ $0.proximity == CLProximity.near}
        let farBeacons          = beacons.filter{ $0.proximity == CLProximity.far}
        let unknownBeacons      = beacons.filter{ $0.proximity == CLProximity.unknown}
        
        print("\n\n------------------")
        print("Ranged beacons: \(beacons.count)")
        
        print("\nHigh signal: \(immediateBeacons.count + nearBeacons.count)")
        
        if immediateBeacons.count != 0 {
            print("\nImmedate Beacons")
            for beacon in immediateBeacons {
                print(beacon)
            }
        }
        
        if nearBeacons.count != 0 {
            print("\nNear Beacons")
            for beacon in nearBeacons {
                print(beacon)
            }
        }
        
        
        print("\nLow signal: \(farBeacons.count + unknownBeacons.count)")
        
        if farBeacons.count != 0 {
            print("\nFar Beacons")
            for beacon in farBeacons {
                print(beacon)
            }
        }
        
        if unknownBeacons.count != 0 {
            print("\nUnknown Beacons")
            for beacon in unknownBeacons {
                print(beacon)
            }
        }
    }*/
    
}

extension ViewController: MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        
    }
}
