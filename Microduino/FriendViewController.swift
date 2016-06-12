//
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
class FriendViewController: UIViewController,DoubleTextViewDelegate{
    
    private var doubleTextView: DoubleTextView!
    private var backgroundScrollView: UIScrollView!
    private var groupViewModel:GroupViewModel?
    private var friendViewModel:FriendViewModel?
    private var friendHotPage : Int = 0
    private var friendLimit:Int = 10
    private var groupHotPage : Int = 0
    private var groupLimit:Int = 10
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
        setScrollView()
        setNav()
        backgroundScrollView.addSubview(friendTableView)
        backgroundScrollView.addSubview(groupTableView)
        
        
        friendViewModel = FriendViewModel(friendTableView:friendTableView)
        groupViewModel = GroupViewModel(groupTableView:groupTableView)
        
        reloadFriendData(friendHotPage,limit: friendLimit)
        reloadGroupData(groupHotPage, limit:groupLimit)
        
        
    }
    
    private func setScrollView() {
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT))
        backgroundScrollView.backgroundColor = UIColor(rgba:"#C8CECD")
        backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2.0, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        view.addSubview(backgroundScrollView)
    }
    
    private func setNav() {
        
        
        doubleTextView = DoubleTextView(leftText: "Friends", rigthText: "groups")
        doubleTextView.frame = CGRectMake(0, 0,160, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
    }
    
    // 列表
    private lazy var friendTableView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let friendTableView = UICollectionView(frame: CGRectMake(0,10,SCREEN_WIDTH, SCREEN_HEIGHT), collectionViewLayout: layout)
        friendTableView .registerClass(Home_Cell.self, forCellWithReuseIdentifier:"cell")
        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.backgroundColor = UIColor(rgba:"#C8CECD")
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/4,(SCREEN_WIDTH-40)/4)
        self.view .addSubview(friendTableView)
        friendTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(tableHeaderRefresh))
        friendTableView.mj_footer = MJRefreshBackFooter(refreshingTarget: self,refreshingAction: #selector(tableFooterRefresh))
        return friendTableView
    }()
    
    // 列表
    private lazy var groupTableView : UITableView = {
        let groupTableView = UITableView(frame:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,SCREEN_HEIGHT), style:UITableViewStyle.Grouped)
        groupTableView.dataSource = self
        groupTableView.delegate = self
        groupTableView.tag = 1001
        groupTableView.backgroundColor = UIColor(rgba:"#C8CECD")
        groupTableView.rowHeight = SCREEN_WIDTH-50
        groupTableView.tableFooterView = UIView(frame: CGRectZero)
        groupTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        groupTableView.registerClass(GroupTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        groupTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(tableHeaderRefresh))
        groupTableView.mj_footer = MJRefreshBackFooter(refreshingTarget: self,refreshingAction: #selector(tableFooterRefresh))
        return groupTableView
    }()
    
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        backgroundScrollView.setContentOffset(CGPointMake(SCREEN_WIDTH * CGFloat(index), 0), animated: true)
        
    }
    
    func tableHeaderRefresh(){
        
        
    }
    
    func tableFooterRefresh(){
        
    }
    
    func reloadFriendData(offset:Int,limit:Int){
        
        showProgress()
        
        let dict: [String: AnyObject] = ["offset":String(offset),"limit":String(limit)]
        
        Meteor.call(ServerAPI.myFriends, params:[dict], callback: { (result, error) in
            if((error) != nil){
                
                self.showNetWorkErrorView()
                self.hiddenProgress()
                
            }else{
                
                self.hiddenProgress()
                if(result?.count! != 0){
                    
                    self.friendViewModel?.ArticleData(result as! NSMutableArray)
                    self.friendHotPage = limit+self.friendHotPage
                    self.friendLimit = limit
                }
            }})}
    
    
    func reloadGroupData(offset:Int,limit:Int){
        
        let dict: [String: AnyObject] = ["offset":String(offset),"limit":String(limit)]
        
        Meteor.call(ServerAPI.myGroups, params:[dict], callback: { (result, error) in
            if((error) != nil){
                
                self.showNetWorkErrorView()
                self.hiddenProgress()
                
            }else{
                
                self.hiddenProgress()
                if(result?.count! != 0){
                   
                    self.groupViewModel?.ArticleData(result as! NSMutableArray)
                    self.groupHotPage = limit+self.groupHotPage
                    self.groupLimit = limit
                   
                }
            }})
        
    }
    
    
}

// MARK: 列表代理
extension FriendViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            if self.groupViewModel != nil {
                return (self.groupViewModel?.newDataSource.count)!
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
        let tableCell1:GroupTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? GroupTableViewCell
            tableCell1?.model = groupViewModel?.newDataSource[indexPath.section]
            return tableCell1!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:false)
        let friendArticlesViewController = FriendArticlesViewController()
        friendArticlesViewController.friendId = groupViewModel?.newDataSource[indexPath.section].card_Id
        friendArticlesViewController.pushType = "group"
        self.navigationController?.pushViewController(friendArticlesViewController, animated:true)
       
    }
    
}
extension FriendViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.friendViewModel != nil {
            return (self.friendViewModel?.newDataSource.count)!
        }
        return 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Home_Cell
        cell.model = friendViewModel?.newDataSource[indexPath.row]
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let friendArticlesViewController = FriendArticlesViewController()
        friendArticlesViewController.friendId = friendViewModel?.newDataSource[indexPath.row].card_Id
        friendArticlesViewController.pushType = "friend"
        self.navigationController?.pushViewController(friendArticlesViewController, animated:true)
    }
}

/// MARK: UIScrollViewDelegate
extension FriendViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}
