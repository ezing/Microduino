//
//  CommentModel.swift
//  Microduino
//
//  Created by harvey on 16/4/11.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import AFDateHelper
class CommentModel: NSObject {

    // 作者id
    var comment_id : String?
    // 作者性别
    var comment_avator : String?
    // 作者描述
    var comment_name : String?
    // 封面图片
    var comment_content : String?
    // 文章标题
    var comment_date:String?
   
    convenience init(dict : NSDictionary) {
        self.init()
        
        self.comment_id = "\(dict["_id"]!)"
        self.comment_avator = "\(dict["avatar"]!)"
        self.comment_name = "\(dict["userName"]!)"
        var string = "\(dict["comment"]!)" as String
        self.comment_content = string.filterHTML()
        let date = NSDate(fromString:"\(dict["date"]!["$date"]!)",format: .DotNet)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateStr = formatter.stringFromDate(date) as NSString
        self.comment_date = dateStr.substringToIndex(19) as String
        
    }
    
    
}
