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
        
        self.navigationBar
            .setBackgroundImage(UIImage(named:"nav_bg"), forBarMetrics: .Default)
        self.navigationBar.translucent = false
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationBar.backIndicatorImage = UIImage(named:"ico_back")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"ico_back")
        self.navigationBar.tintColor = UIColor(rgba:"#AAFF18")
        self.hidesBarsOnSwipe = true

    }


}