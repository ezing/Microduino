//
//  DiscoverDetailModel.swift
//  Microduino
//
//  Created by harvey on 16/3/29.
//  Copyright © 2016年 harvey. All rights reserved.
//


import UIKit

class ArticleModel: NSObject {

    // 内容
    var content : String?
    var author_avator:String?
    var author_name:String?
    var author_id:String?
    var article_shareUrl:String?
    var isFavorite:Int?
    var favcount:Int?
    var isFollowingAuthor:Int?

    convenience init(dict : NSDictionary) {
        
        self.init()
   
        self.content = dict["content"] as? String
        self.author_avator = dict["avatar"] as? String
        self.author_name = dict["authorName"] as? String
        self.author_id = dict["authorId"] as? String
        self.article_shareUrl = dict["url"] as? String
        self.isFavorite = dict["isFavorite"] as? Int
        self.favcount = dict["favcount"] as? Int
        self.isFollowingAuthor = dict["isFollowingAuthor"] as? Int
    

    }
  
    
}
