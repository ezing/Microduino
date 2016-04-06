//
//  UINavigationController+Extension.swift
//  Microduino
//
//  Created by harvey on 16/3/21.
//  Copyright © 2016年 harvey. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController{

    override public func viewDidLoad() {
        
        self.navigationBar.barTintColor = UIColor(rgba:"#6B6C6D")
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        
        
    }


}