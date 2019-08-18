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
    }

    @IBAction func onTimerTapped() {
        UNService.shared.requestTimer(with: 3)
    }
    
    @IBAction func onDateTapped() {
        var components = DateComponents()
        
        components.second = 5
        
        UNService.shared.requestDate(with: components)
    }
    
    @IBAction func onLocationTapped() {
        print("Location")
    }

}

