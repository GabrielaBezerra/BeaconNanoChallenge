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
        
        let myProximityUuid = UUID(uuidString: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E")
        let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon region 1")
        
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined:
            beaconManager.requestLocationAlwaysAuthorization()
        case .authorizedAlways:
            if KTKBeaconManager.isMonitoringAvailable() {
                beaconManager.startMonitoring(for: region)
            }
        case .denied, .restricted: break
        case .authorizedWhenInUse: break
        }

    }
    
}

extension ViewController: KTKBeaconManagerDelegate {
    
 /*   func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {

        let myProximityUuid = UUID(uuidString: "A1EA8130-0E1B-D4A1-B840-63F88C8DA1EA")
        let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon region 1")
        
        if status == .authorizedAlways {
            if KTKBeaconManager.isMonitoringAvailable() {
                beaconManager.startMonitoring(for: region)
            }
        }
    }
 */
    
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
        // Decide what to do when a user enters a range of your region; usually used
        // for triggering a local notification and/or starting a beacon ranging
        manager.startRangingBeacons(in: region)
        print("Entered region")
        label.text = "Entered  \(region)"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        // Decide what to do when a user exits a range of your region; usually used
        // for triggering a local notification and stoping a beacon ranging
        manager.stopRangingBeacons(in: region)
        print("Left Region")
        label.text = "Left \(region)"
    }
    
    func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        print("didRange")
    }
    
    func beaconManager(_ manager: KTKBeaconManager, rangingBeaconsDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        print(region!)
        print("Failed")
    }
}
