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

class GroupViewModel: NSObject {
    //文章列表
    private weak var groupTableView : UITableView!
    
    var newDataSource : Array<GroupModel> = Array()
    
    convenience init(groupTableView : UITableView) {
        
        self.init()
        
        self.groupTableView = groupTableView
    }
    
    func ArticleData(result:NSMutableArray){
        
        for dict in result {
            let groupModel : GroupModel = GroupModel(dict: dict as! NSDictionary)
            self.newDataSource.append(groupModel)
            self.groupTableView.reloadData()
            
        }
    }
}