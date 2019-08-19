//
//  ViewController.swift
//  Notification01
//
//  Created by R. Kukuh on 13/08/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNService.shared.authorize()
        CLService.shared.authorize()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("notification.enteredRegion"),
                                               object: nil)
    }

    @IBAction func onTimerTapped() {
        AlertService.actionSheet(in: self, title: "3 seconds") {
            UNService.shared.requestTimer(with: 3)
        }
    }
    
    @IBAction func onDateTapped() {
        AlertService.actionSheet(in: self, title: "5th second of every minute") {
            var components = DateComponents()
            
            components.second = 5
            
            UNService.shared.requestDate(with: components)
        }
    }
    
    @IBAction func onLocationTapped() {
        AlertService.actionSheet(in: self, title: "When I come back") {
            CLService.shared.updateLocation()
        }
    }
    
    @objc
    func didEnterRegion() {
        UNService.shared.requestLocation()
    }

}

