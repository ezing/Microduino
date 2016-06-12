//
//  TestServerData.swift
//  Microduino
//
//  Created by harvey on 16/5/25.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import SwiftDDP

class TestServerData:UIViewController{

    var colltionView : UICollectionView?
    var dataArr = NSMutableArray()
    
    override func viewDidLoad() {
        
        Meteor.client.logLevel = .Error
        Meteor.client.allowSelfSignedSSL = false
        
        Meteor.connect(ServerAPI.TEST_HOST_NAME){
            
//            //  单个card的内容
//            Meteor.call("mobile/card_show", params:["AujtdrMQCAKX6iFJ4"], callback: { (result, error) in })
//            //Articles
//            Meteor.call("mobile/articles", params:[dict], callback: { (result, error) in })
//          }
            testGroup()
            
        
        }
    
  
       
    
    }
}


//MARK:登陆功能

func testLogin(){

    //  登陆
    Meteor.loginWithPassword("zidong0822@sina.cn", password:"15034292610wo", callback: { (result, error) in
        
        print("登录结果\(result),错误原因\(error)")
    })
    

}

//MARK:发现模块

func testDiscover(){

    let dict: [String: AnyObject] = ["offset":String(0),"limit":String(30)]
    // Card
    Meteor.call("mobile/cards", params:[dict], callback: { (result, error) in
        
        
        print("cards结果\(result),错误原因\(error)")
    })
    
 
    
}

//MARK:创友圈模块

func testGroup(){

    let dict: [String: AnyObject] = ["offset":String(0),"limit":String(30)]
    
    Meteor.call("mobile/my_groups", params:[dict], callback: { (result, error) in
    
        print("my_groups结果\(result),错误原因\(error)")  //  返回当前用户加入的组
    })
    
    Meteor.call("mobile/group_show", params:["4kMGxFeTieZXogk5o"], callback: { (result, error) in
        
        print("group_show结果\(result),错误原因\(error)")   //返回当前组的所有文章
    })
    
    Meteor.call("mobile/my_friends", params:[dict], callback: { (result, error) in
    
        print("my_friends结果\(result),错误原因\(error)")   //返回当前用户follow的人
    })
    
    Meteor.call("mobile/friend_articles", params:["ytpp3mLib8GKhRpZy",dict], callback: { (result, error) in
    
    print("friend_articles结果\(result),错误原因\(error)")   //返回follow作者的所有文章列表
    
    })
                
}

func testUser(){

    let dict: [String: AnyObject] = ["offset":String(0),"limit":String(30)]
    
    Meteor.call("mobile/friends", params:[dict], callback: { (result, error) in
    
        print("friends结果\(result),错误原因\(error)")   // 返回所有用户
    })
    
    Meteor.call("mobile/groups", params:[dict], callback: { (result, error) in
        
        print("groups结果\(result),错误原因\(error)")    //返回所有组
    })
    
}


//MARK:智造间模块

func testMyArticles(){

    let dict: [String: AnyObject] = ["offset":String(0),"limit":String(30)]
    
    Meteor.call("mobile/my_articles", params:[dict], callback: { (result, error) in
    
        print("my_articles结果\(result),错误原因\(error)")
    })
    
    Meteor.call("mobile/my_fav_articles", params:[dict], callback: { (result, error) in
        
        print("my_fav_articles结果\(result),错误原因\(error)")  //  当前用户点赞过的所有文章
    })
}

//MARK:写文章模块

func testWriteArticle(){
   
    Meteor.call("mobile/article_new", params:["手机端写文章","111111111111","手机端可以实现写文章啦"], callback: { (result, error) in
    
        print("写文章结果\(result),错误原因\(error)")
    })
    
}

//MARK:文章详情页模块

func testArticleDetail(){


    // 文章详情  正确
    Meteor.call("mobile/article_show", params:["ixCdAmxbQchrcCTGg"], callback: { (result, error) in
        
        print("article详情显示\(result),错误原因\(error)")
    })
    //  作者follow   正确
    Meteor.call("mobile/friend_follow", params:["ytpp3mLib8GKhRpZy"], callback: { (result, error) in
    
        print("follow结果\(result),错误原因\(error)")
    })
    
    // 评论详情  正确
        Meteor.call("mobile/comments", params:["JBNGtoTe9aPfiu3pQ"], callback: { (result, error) in
    
            print("评论结果\(result),错误原因\(error)")
    })
    
    // 点赞  正确
    Meteor.call("mobile/article_favorite", params:["JBNGtoTe9aPfiu3pQ"], callback: { (result, error) in
    
            print("点赞结果\(result),错误原因\(error)")
    })
    
    let dict1: [String: AnyObject] = ["linkedObjectId":"JBNGtoTe9aPfiu3pQ","comment":"中文评论".convertToUTF8()]
    
    // 添加评论  正确
    Meteor.call("mobile/comment_add", params:[dict1], callback: { (result, error) in
    
            print("评论结果\(result),错误原因\(error)")
    })
                
    

}
