//
//  DiscoverViewModel.swift
//  Microduino
//
//  Created by harvey on 16/3/23.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import Alamofire
import SwiftDDP

class DiscoverViewModel: NSObject {

    //文章列表
    private weak var articleTable : UITableView!
    
    //最新文章
    var newDataSource : Array<DiscoverModel> = Array()
    // 回调
    typealias DiscoveryViewModelSuccessCallBack = (dataSoure : Array<DiscoverModel>) -> Void
    typealias DiscoveryVieModelErrorCallBack = (error : NSError) -> Void
    var successCallBack : DiscoveryViewModelSuccessCallBack?
    var errorCallBack : DiscoveryVieModelErrorCallBack?
    
    convenience init(articleTable : UITableView) {
       
        self.init()
        self.articleTable = articleTable
    }
    
    func initArticleData(result:NSMutableArray){
    
        for dict in result {
            let discoverModel : DiscoverModel = DiscoverModel(dict: dict as! NSDictionary)
            
            self.newDataSource.append(discoverModel)
            self.articleTable.reloadData()
            
        }
    }}
