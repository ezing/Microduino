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

class CreationViewModel: NSObject {
    
    //文章列表
    private weak var creationTable : UITableView!
    
    var newDataSource : Array<ArticlesModel> = Array()
    
    convenience init(creationTable : UITableView) {
        
        self.init()
        self.creationTable = creationTable
    }
    
    func ArticleData(result:NSMutableArray){
        
        for dict in result {
            let articlesModel : ArticlesModel = ArticlesModel(dict: dict as! NSDictionary)
            self.newDataSource.append(articlesModel)
            self.creationTable.reloadData()
            
        }
    }
}