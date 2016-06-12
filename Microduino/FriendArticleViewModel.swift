//
//  FavoriteViewModel.swift
//  Microduino
//
//  Created by harvey on 16/6/2.
//  Copyright © 2016年 harvey. All rights reserved.
//

//
//  ArticlesViewModel.swift
//  Microduino
//
//  Created by harvey on 16/6/2.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftDDP

class FriendArticleViewModel: NSObject {
    
    //文章列表
    private weak var friendArticleTable : UITableView!
    
    var newDataSource : Array<ArticlesModel> = Array()
    
    convenience init(friendArticleTable : UITableView) {
        
        self.init()
        self.friendArticleTable = friendArticleTable
    }
    
    func ArticleData(result:NSMutableArray){
        
        for dict in result {
            let articlesModel : ArticlesModel = ArticlesModel(dict: dict as! NSDictionary)
            self.newDataSource.append(articlesModel)
            self.friendArticleTable.reloadData()
            
        }
    }
}