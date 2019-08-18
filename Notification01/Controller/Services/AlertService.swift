//
//  AlertService.swift
//  Notification01
//
//  Created by R. Kukuh on 18/08/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import Foundation

class AlertService {
    
    private init() {}
    
    static func actionSheet(in viewController: UIViewController, title: String, completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true)
    }
}
