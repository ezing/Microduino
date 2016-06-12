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

class FriendViewModel: NSObject {
    //文章列表
    private weak var FriendTableView : UICollectionView!
    
    var newDataSource : Array<FriendModel> = Array()
    
    convenience init(friendTableView : UICollectionView) {
        
        self.init()
        
        self.FriendTableView = friendTableView
    }
    
    func ArticleData(result:NSMutableArray){
        
        for dict in result {
            
            let friendModel : FriendModel = FriendModel(dict: dict as! NSDictionary)
            self.newDataSource.append(friendModel)
            self.FriendTableView.reloadData()
            
        }
    }
}