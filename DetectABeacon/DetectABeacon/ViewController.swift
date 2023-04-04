//
//  ViewController.swift
//  DetectABeacon
//
//  Created by Artem Marhaza on 04/04/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let label = UILabel()
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        setup()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }
    
    private func setup() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .thin)
        label.text = "UNKNOWN"
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconConstraint = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: beaconConstraint, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconConstraint)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.label.text = "FAR"
            case .near:
                self.view.backgroundColor = .orange
                self.label.text = "NEAR"
            case .immediate:
                self.view.backgroundColor = .red
                self.label.text = "RIGHT HERE"
            default:
                self.view.backgroundColor = .gray
                self.label.text = "UNKNOWN"
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
}

