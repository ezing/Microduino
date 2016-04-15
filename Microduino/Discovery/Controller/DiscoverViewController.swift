//
//  ViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import Fuzi
import SwiftDDP
import MJRefresh
class DiscoverViewController: UIViewController {

    private var viewModel : DiscoverViewModel?
    private var hotPage : Int = 0
    private var limit:Int = 10
    var tableView : UITableView?
  
    override func viewDidLoad() {
        super.viewDidLoad()
 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(errorBtnDidClick), name: NOTIFY_ERRORBTNCLICK, object: nil)
        Meteor.client.logLevel = .Error
        Meteor.client.allowSelfSignedSSL = true
        
        createUI()
        showProgress()
        viewModel = DiscoverViewModel(articleTable:self.tableView!)
        reloadData(hotPage,limit: limit)

        
    }
    
    func createUI(){
    
        let navigationView = DiscoverNavigationView(frame:CGRectMake(0,0,SCREEN_WIDTH,64))
        self.view.addSubview(navigationView)
        
        self.tableView = UITableView(frame:CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT-64), style:UITableViewStyle.Grouped)
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.tableView?.rowHeight = SCREEN_WIDTH-40
        self.tableView!.tableFooterView = UIView()
        self.tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView!.registerClass(DiscoverTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self,refreshingAction: #selector(tableFooterRefresh))
        self.view!.addSubview(self.tableView!)
        
        let menuButton=UIButton(frame: CGRectMake(20,30,20,20))
        menuButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton.setImage(UIImage(named:"menu"), forState: UIControlState.Normal)
        menuButton.addTarget(self, action:#selector(doneSlide), forControlEvents: UIControlEvents.TouchUpInside)
        navigationView.addSubview(menuButton)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
      self.navigationController!.navigationBar.hidden = true;
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension DiscoverViewController:UITableViewDelegate,UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.viewModel != nil {
            return (self.viewModel?.newDataSource.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIndentifier :String = "cellIdentifier";
        let tableCell:DiscoverTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? DiscoverTableViewCell
        tableCell!.selectionStyle = UITableViewCellSelectionStyle.None
        tableCell?.backgroundColor = UIColor(rgba:"#F2F2F6")
        tableCell?.model = viewModel?.newDataSource[indexPath.section]
        return tableCell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:false)
        let discoverDetailViewController = DiscoverDetailViewController()
        discoverDetailViewController.card_Id = viewModel?.newDataSource[indexPath.section].card_Id
        discoverDetailViewController.card_Type = viewModel?.newDataSource[indexPath.section].card_Type
        self.navigationController?.pushViewController(discoverDetailViewController, animated:true)
    }
    
}

extension DiscoverViewController{

    
    func doneSlide(){
        
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left ,animated:true, completion:nil);
        
    }
    func errorBtnDidClick() {
        
        reloadData(hotPage,limit:limit)
    }
    
    func tableFooterRefresh(){
    
        let workingQueue = dispatch_queue_create("my_queue", nil)
        dispatch_async(workingQueue) {
            dispatch_async(dispatch_get_main_queue()) {
                self.reloadData(self.hotPage, limit:self.limit)
                self.tableView?.reloadData()
                self.tableView?.mj_footer.endRefreshing()
            }
        }

    
    
    }
    
    func reloadData(offset:Int,limit:Int){
      
        let dict: [String: AnyObject] = ["offset":String(offset),"limit":String(limit)]
        Meteor.connect(HOST_NAME){
        
        Meteor.loginWithPassword("zidong0822@sina.cn", password: "15034292610wo") { result, error in

            
        }
        Meteor.call("mobile/cards", params:[dict], callback: { (result, error) in
                if((error) != nil){
                    self.showNetWorkErrorView()
                    self.hiddenProgress()
                    
                }else{
                    self.hiddenProgress()
                    self.viewModel?.initArticleData(result as! NSMutableArray)
                    self.hotPage = limit
                    self.limit = limit+10
                    
                }})
            }
    }
    }

