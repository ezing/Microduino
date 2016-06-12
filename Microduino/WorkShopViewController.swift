//
//  WorkShopViewController.swift
//  Microduino
//
//  Created by harvey on 16/6/2.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftDDP
class WorkShopViewController: UIViewController,DoubleTextViewDelegate{

    private var doubleTextView: DoubleTextView!
    private var backgroundScrollView: UIScrollView!
    private var creationViewModel : CreationViewModel?
    private var favoriteViewModel:FavoriteViewModel?
    private var creationHotPage : Int = 0
    private var creationLimit:Int = 10
    private var favoriteHotPage : Int = 0
    private var favoriteLimit:Int = 10
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
        setScrollView()
        setNav()
        backgroundScrollView.addSubview(creationTableView)
        backgroundScrollView.addSubview(favoriteTableView)
        
        creationViewModel = CreationViewModel(creationTable:creationTableView)
        favoriteViewModel = FavoriteViewModel(favoriteTable:favoriteTableView)
        reloadCreationData(creationHotPage,limit: creationLimit)
        reloadFavoriteData(favoriteHotPage, limit:favoriteLimit)
        
        
    }
    
    
    private func setScrollView() {
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT))
        backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2.0, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        view.addSubview(backgroundScrollView)
    }
    
    private func setNav() {
       
        
        doubleTextView = DoubleTextView(leftText: "Creation", rigthText: "Favorite")
        doubleTextView.frame = CGRectMake(0, 0,160, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
    }
    
    // 列表
    private lazy var creationTableView : UITableView = {
        let creationTableView = UITableView(frame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT), style:UITableViewStyle.Grouped)
        creationTableView.dataSource = self
        creationTableView.delegate = self
        creationTableView.tag = 1000
        creationTableView.backgroundColor = UIColor(rgba:"#C8CECD")
        creationTableView.rowHeight = SCREEN_WIDTH-50
        creationTableView.tableFooterView = UIView(frame: CGRectZero)
        creationTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        creationTableView.registerClass(CreationTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        creationTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(tableHeaderRefresh))
        creationTableView.mj_footer = MJRefreshBackFooter(refreshingTarget: self,refreshingAction: #selector(tableFooterRefresh))
        return creationTableView
    }()

    // 列表
    private lazy var favoriteTableView : UITableView = {
        let favoriteTableView = UITableView(frame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT), style:UITableViewStyle.Grouped)
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        favoriteTableView.tag = 1001
        favoriteTableView.backgroundColor = UIColor(rgba:"#C8CECD")
        favoriteTableView.rowHeight = SCREEN_WIDTH-50
        favoriteTableView.tableFooterView = UIView(frame: CGRectZero)
        favoriteTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        favoriteTableView.registerClass(FavoriteTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        favoriteTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(tableHeaderRefresh))
        favoriteTableView.mj_footer = MJRefreshBackFooter(refreshingTarget: self,refreshingAction: #selector(tableFooterRefresh))
        return favoriteTableView
    }()
    
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        backgroundScrollView.setContentOffset(CGPointMake(SCREEN_WIDTH * CGFloat(index), 0), animated: true)
       
    }
    
    func tableHeaderRefresh(){
    
    
    }
    
    func tableFooterRefresh(){
    
    }
    
    func reloadCreationData(offset:Int,limit:Int){
        
        showProgress()
        
        let dict: [String: AnyObject] = ["offset":String(offset),"limit":String(limit)]
            
            Meteor.call(ServerAPI.myArticles, params:[dict], callback: { (result, error) in
                if((error) != nil){
                    
                    self.showNetWorkErrorView()
                    self.hiddenProgress()
                    
                }else{
                    
                    self.hiddenProgress()
                    if(result?.count! != 0){
                        
                        self.creationViewModel?.ArticleData(result as! NSMutableArray)
                        self.creationHotPage = limit+self.creationHotPage
                        self.creationLimit = limit
                    }
                }})}
    
    
    func reloadFavoriteData(offset:Int,limit:Int){
        
        let dict: [String: AnyObject] = ["offset":String(offset),"limit":String(limit)]
        
        Meteor.call(ServerAPI.myFavArticles, params:[dict], callback: { (result, error) in
            if((error) != nil){
                
                self.showNetWorkErrorView()
                self.hiddenProgress()
                
            }else{
                
                self.hiddenProgress()
                if(result?.count! != 0){
                    
                    self.favoriteViewModel?.ArticleData(result as! NSMutableArray)
                    self.favoriteHotPage = limit+self.favoriteHotPage
                    self.favoriteLimit = limit
                }
            }})
    
    }
    
    
}

// MARK: 列表代理
extension WorkShopViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView.tag == 1000{
            if self.creationViewModel != nil {
                return (self.creationViewModel?.newDataSource.count)!
            }
        }else{
            if self.favoriteViewModel != nil {
                return (self.favoriteViewModel?.newDataSource.count)!
            }
        
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIndentifier :String = "cellIdentifier";
        if tableView.tag == 1000{
            
            let tableCell1:CreationTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? CreationTableViewCell
             tableCell1!.selectionStyle = UITableViewCellSelectionStyle.None

        tableCell1?.model = creationViewModel?.newDataSource[indexPath.section]
        return tableCell1!
        }else{
            let tableCell2:FavoriteTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? FavoriteTableViewCell
            tableCell2!.selectionStyle = UITableViewCellSelectionStyle.None
            tableCell2?.model = favoriteViewModel?.newDataSource[indexPath.section]
            return tableCell2!

        
        }
       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:false)
        let discoverDetailViewController = DiscoverDetailViewController()
        if tableView.tag == 1000{
       
            discoverDetailViewController.card_Id = creationViewModel?.newDataSource[indexPath.section].card_Id
            discoverDetailViewController.card_Type = creationViewModel?.newDataSource[indexPath.section].card_type
        }else{
            
            discoverDetailViewController.card_Id = favoriteViewModel?.newDataSource[indexPath.section].card_Id
            discoverDetailViewController.card_Type = favoriteViewModel?.newDataSource[indexPath.section].card_type
            
        
        }
        self.navigationController?.pushViewController(discoverDetailViewController, animated:true)

    }
    
}
/// MARK: UIScrollViewDelegate
extension WorkShopViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}