//
//  DiscoverDetailModel.swift
//  Microduino
//
//  Created by harvey on 16/3/29.
//  Copyright © 2016年 harvey. All rights reserved.
//


import UIKit

class DiscoverDetailModel: NSObject {

    // 内容
    var content : String?

    convenience init(dict : NSDictionary) {
        
        self.init()
        self.content = dict["content"] as? String
    }
  
    
}
