//
//  ArticleModel.swift
//  Microduino
//
//  Created by harvey on 16/6/2.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class FriendModel: NSObject {
    
    // 作者头像
    var author_avator : String?
    // 作者描述
    var author_name : String?
    // 封面图片
    var cover_image : String?
    // 文章标题
    var article_title:String?
    // 文章id
    var card_Id:String?
    // 文章类型
    var card_type:String?
    // 写作日期
    var write_date:String?
    // 成员个数
    var memberCount:String?
    // follow人数
    var followedCount:String?
    
    convenience init(dict : NSDictionary) {
        self.init()
        
        self.card_Id = "\(dict["friendId"]!)"
        self.author_avator = "\(dict["avatar"]!)"
        self.author_name = "\(dict["friendName"]!)"
   
        
        
        //        let date = NSDate(fromString:"\(dict["updatedAt"]!["$date"]!)",format: .DotNet)
        //        let formatter = NSDateFormatter()
        //        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        //        let dateStr = formatter.stringFromDate(date) as NSString
        //        self.write_date =  dateStr.substringToIndex(19) as String
        
    }
    
    
    
}
