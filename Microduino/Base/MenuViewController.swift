//
//  LeftViewController.swift
//  Blynk
//
//  Created by HeHongwe on 16/2/19.
//  Copyright © 2016年 harvey. All rights reserved.

import UIKit
import MMDrawerController
var menuArray:NSMutableArray = ["Discover","BT Burn","Store","Friends","Group","Favorite","Login out"]
class MenuViewController: UIViewController{

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        setTableView()
    }
  
    func setTableView(){
        
        tableView = UITableView(frame: CGRectMake(0,10,SCREEN_WIDTH * 0.8,SCREEN_HEIGHT), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        view.addSubview(tableView)
        
    }

}


extension MenuViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell=UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell?.textLabel?.text = menuArray[indexPath.row] as? String
        }
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        let centerViewController = DiscoverViewController()
        let centerNavigationController = UINavigationController(rootViewController: centerViewController)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerController.centerViewController = centerNavigationController
        appDelegate.drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)

        
    }


}