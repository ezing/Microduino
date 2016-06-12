//
//  ViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import SwiftDDP
import MJRefresh
import RZTransitions
class FriendArticlesViewController: UIViewController {
    
    private var viewModel : FriendArticleViewModel?
    private var hotPage : Int = 0
    private var limit:Int = 10
    var friendId:String?
    var pushType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Meteor.client.logLevel = .Error
        Meteor.client.allowSelfSignedSSL = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:writeButton)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.view.addSubview(tableView)
        
        viewModel = FriendArticleViewModel(friendArticleTable:tableView)
        reloadData(hotPage,limit: limit,friendId: friendId!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(errorBtnDidClick), name: NOTIFY_ERRORBTNCLICK, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(writeArticle), name:"writeArticle", object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // 写文章
    private lazy var writeButton:UIButton = {
        
        let writeButton = UIButton(frame: CGRectMake(SCREEN_WIDTH-20,20,30,30))
        writeButton.setImage(UIImage(named:"write_article"), forState: UIControlState.Normal)
        writeButton.addTarget(self, action:#selector(writeArticle), forControlEvents: UIControlEvents.TouchUpInside)
        return writeButton
    }()
    //  返回按钮
    private lazy var returnBtn :UIButton = {
        
        let returnBtn : UIButton = UIButton(frame:CGRectMake(10,25,30,30))
        returnBtn.setImage(UIImage(named: "ico_back"), forState: .Normal)
        returnBtn.setImage(UIImage(named: "ico_back"), forState: .Highlighted)
        return returnBtn
        
    }()
    // 列表
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-64), style:UITableViewStyle.Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(rgba:"#C8CECD")
        tableView.rowHeight = SCREEN_WIDTH-50
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.registerClass(FriendArticlesTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self,refreshingAction: #selector(tableHeaderRefresh))
        tableView.mj_footer = MJRefreshBackFooter(refreshingTarget: self,refreshingAction: #selector(tableFooterRefresh))
        return tableView
    }()
    
}

// MARK: 列表代理
extension FriendArticlesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.viewModel != nil {
            return (self.viewModel?.newDataSource.count)!
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
        let tableCell:FriendArticlesTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? FriendArticlesTableViewCell
        tableCell?.model = viewModel?.newDataSource[indexPath.section]
        return tableCell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:false)
        let discoverDetailViewController = DiscoverDetailViewController()
        discoverDetailViewController.modalPresentationStyle = UIModalPresentationStyle.Custom;
        discoverDetailViewController.card_Id = viewModel?.newDataSource[indexPath.section].card_Id
        discoverDetailViewController.card_Type = viewModel?.newDataSource[indexPath.section].card_type
        self.navigationController?.pushViewController(discoverDetailViewController, animated:true)
    }
    
}

// MARK: 扩展方法
extension FriendArticlesViewController{
    
    
    func writeArticle(){
        
        let centerViewController = TextKitViewController()
        let centerNavigationController = UINavigationController(rootViewController: centerViewController)
        self.navigationController?.presentViewController(centerNavigationController, animated: true, completion: {
            
        })
    }
    
    func reloadData(offset:Int,limit:Int,friendId:String){
        
        showProgress()
        
        let dict: [String: AnyObject] = ["offset":String(offset),"limit":String(limit)]
        if(pushType == "friend"){
            Meteor.call(ServerAPI.friendArticles, params:[friendId,dict], callback: { (result, error) in
                if((error) != nil){
                    self.showNetWorkErrorView()
                    self.hiddenProgress()
                    
                }else{
                    
                    self.hiddenProgress()
                    if(result?.count! != 0){
                        self.viewModel?.ArticleData(result as! NSMutableArray)
                        self.hotPage = limit+self.hotPage
                        self.limit = limit
                    }
                }})

        }else{
            Meteor.call(ServerAPI.groupArticles, params:[friendId], callback: { (result, error) in
                if((error) != nil){

                    self.showNetWorkErrorView()
                    self.hiddenProgress()
                    
                }else{
                    
                    self.hiddenProgress()
                    if(result?.count! != 0){
            
                        self.viewModel?.ArticleData(result?.objectForKey("articles") as! NSMutableArray)
                        self.hotPage = limit+self.hotPage
                        self.limit = limit
                    }
                }})

        }
    }
    
    
    
    func errorBtnDidClick() {
        
        reloadData(hotPage,limit:limit,friendId: friendId!)
    }
    
    func tableFooterRefresh(){
        
        self.reloadData(self.hotPage, limit:self.limit,friendId: friendId!)
        self.tableView.reloadData()
        self.tableView.mj_footer.endRefreshing()
        
    }
    
    
    func tableHeaderRefresh(){
        
        hotPage = 0
        limit = 10
        self.reloadData(self.hotPage, limit:self.limit,friendId: friendId!)
        self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
    }
    
}


