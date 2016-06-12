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

class FavoriteViewModel: NSObject {
    
    //文章列表
    private weak var favoriteTable : UITableView!
    
    var newDataSource : Array<ArticlesModel> = Array()
    
    convenience init(favoriteTable : UITableView) {
        
        self.init()
        self.favoriteTable = favoriteTable
    }
    
    func ArticleData(result:NSMutableArray){
        
        for dict in result {
            let articlesModel : ArticlesModel = ArticlesModel(dict: dict as! NSDictionary)
            self.newDataSource.append(articlesModel)
            self.favoriteTable.reloadData()
            
        }
    }
}