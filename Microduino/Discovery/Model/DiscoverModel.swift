//
//  DiscoverModel.swift
//  Microduino
//
//  Created by harvey on 16/3/23.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class DiscoverModel: NSObject {
    // 作者id
    var author_id : String?
    // 作者性别
    var author_avator : String?
    // 作者描述
    var author_name : String?
    // 封面图片
    var cover_image : String?
    // 文章标题
    var article_title:String?
 
    convenience init(dict : NSDictionary) {
        self.init()
        
        self.author_id = dict["_id"] as? String
        self.author_avator = dict["saLKsf3m3bDi3cCiY"] as? String
        self.author_name = dict["type"] as? String
        self.cover_image = "\(dict["picture"]!)"
        self.article_title = "\(dict["title"]!)"
       
    }
    
}
