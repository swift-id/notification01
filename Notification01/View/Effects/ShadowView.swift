//
//  Shadow.swift
//  Notification01
//
//  Created by R. Kukuh on 13/08/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 5
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowPath = CGPath(rect: layer.bounds, transform: nil)
    }

}
