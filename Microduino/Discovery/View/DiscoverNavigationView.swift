//
//  DiscoverNavigationView.swift
//  Microduino
//
//  Created by harvey on 16/3/28.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class DiscoverNavigationView: UIView {

    var titleLabel:UILabel!
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        self.backgroundColor = UIColor(rgba:"#6B6C6D")
        self.titleLabel = UILabel(frame:CGRectMake(0,10,SCREEN_WIDTH,64))
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.text = "发现"
        self.titleLabel.textColor = UIColor.whiteColor()
        self.addSubview(titleLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}
