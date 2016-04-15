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
    
    var card_Id:String?
    
    var card_Type:String?
 
    convenience init(dict : NSDictionary) {
        self.init()
        
        self.author_id = "\(dict["_id"]!)"
        self.author_avator = "\(dict["picture"]!)"
        self.author_name = "\(dict["type"]!)"
        self.cover_image = "\(dict["picture"]!)"
        self.article_title = "\(dict["title"]!)"
        self.card_Id = "\(dict["cardId"]!)"
        self.card_Type = "\(dict["type"]!)"
       
    }
    
}
