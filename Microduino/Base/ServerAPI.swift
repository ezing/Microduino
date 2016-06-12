//
//  ServerAPI.swift
//  Microduino
//
//  Created by harvey on 16/6/1.
//  Copyright © 2016年 harvey. All rights reserved.
//


import UIKit

class ServerAPI: NSObject {

    static var TEST_HOST_NAME:String = "ws://dev.microduino.cn:80/websocket"
    static var HOST_NAME:String = "wss://www.microduino.cn:443/websocket"
    static var NATIVE_HOST_NAME:String = "ws://192.168.8.18:3000/websocket"
    
    static var discoverCards:String = "mobile/cards"
    static var articleComments:String = "mobile/comments"
    static var articleShow:String = "mobile/article_show"
    static var friendFollow:String = "mobile/friend_follow"
    static var friendunFollow:String = "mobile/friend_unfollow"
    static var commentAdd:String = "mobile/comment_add"
    static var myArticles:String = "mobile/my_articles"
    static var myFavArticles:String = "mobile/my_fav_articles"
    static var myFriends:String = "mobile/my_friends"
    static var myGroups:String = "mobile/my_groups"
    static var articleFavorite:String = "mobile/article_favorite"
    static var friendArticles:String = "mobile/friend_articles"
    static var groupArticles:String = "mobile/group_show"
    
    
   
    
}

