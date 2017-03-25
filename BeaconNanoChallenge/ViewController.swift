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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var viewLoading: UIView!
    @IBOutlet weak var devicesTable: UITableView!
    let locationManager = CLLocationManager()

    @IBOutlet weak var lblNumberOfDevices: UILabel!
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")!, identifier: "Bacon")
    
    //Multipeer
    let peerID = MCPeerID(displayName: UIDevice.current.name)
    let serviceType = "nano"
    
    let devices = ["Fulano", "Beltrano", "Teobaldo", "Iphone de Derpino", "iPad do Doidim lá", "Sem ideia"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivityIndicatory(uiView: self.viewLoading)
        
        locationManager.delegate = self
        devicesTable.delegate = self
        devicesTable.dataSource = self
        
        lblNumberOfDevices.text = "\(devices.count)"
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myCell")
        cell.textLabel?.text = devices[indexPath.row]
        
        return cell
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("beacon ranged")
        let immediateBeacons = beacons.filter{ $0.proximity == CLProximity.immediate }
        let nearBeacons      = beacons.filter{ $0.proximity == CLProximity.near }
        
        
        if((immediateBeacons.count + nearBeacons.count) >= 3){
            self.viewLoading.isHidden = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let view = viewLoading{
            if viewLoading.isHidden{
                return .lightContent
            }
        }
        return .default
    }
    
    func showActivityIndicatory(uiView: UIView) {
        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: self.view.frame.midX, y: self.view.frame.midX, width: 300, height: 300)
        actInd.center = uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.gray
        uiView.addSubview(actInd)
        actInd.startAnimating()
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
