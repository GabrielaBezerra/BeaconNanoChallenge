//
//  ViewController.swift
//  BeaconNanoChallenge
//
//  Created by Gabriela de Carvalho Barros Bezerra on 23/03/17.
//  Copyright © 2017 Gabriela Bezerra. All rights reserved.
//

import UIKit
import CoreLocation
import KontaktSDK

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var beaconManager: KTKBeaconManager!
    
    //let myProximityUuid = UUID(uuidString: "E063A66C-146F-42B1-AC3C-36BA3640B7ED")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager = KTKBeaconManager(delegate: self)
      
        beaconManager.stopMonitoringForAllRegions()
    
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined:
            beaconManager.requestLocationAlwaysAuthorization()
        case .authorizedAlways: break
        case .denied, .restricted: break
        case .authorizedWhenInUse: break
        }

    }
    
}

extension ViewController: KTKBeaconManagerDelegate {
    
    func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {

        let myProximityUuid = UUID(uuidString: "A1EA8130-0E1B-D4A1-B840-63F88C8DA1EA")
        let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Bacon")
        
        if status == .authorizedAlways {
            if KTKBeaconManager.isMonitoringAvailable() {
                beaconManager.startMonitoring(for: region)
            }
        }
    }
 
    
    func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        
        label.text = "Monitoring..."
        print("Started Monitoring the following regions:")
        print(beaconManager.monitoredRegions)
        
    }
    
    func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        print("failed")
        label.text = "Failed"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        manager.startRangingBeacons(in: region)
        print("Entered region")
        label.text = "Entered region \(region)"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        manager.stopRangingBeacons(in: region)
        print("Left Region")
        label.text = "Left region \(region)"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        print("did range beacons:\n \(beacons)")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, rangingBeaconsDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        print(region!)
        print("Failed")
    }
}
