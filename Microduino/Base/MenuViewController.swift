//
//  LeftViewController.swift
//  Blynk
//
//  Created by HeHongwe on 16/2/19.
//  Copyright © 2016年 harvey. All rights reserved.

import UIKit


enum LeftMenu: Int {
    case Discover = 0
    case WorkShop
    case Java
    case Go
    case NonMenu
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}
class MenuViewController: UIViewController{

    private var tableView: UITableView!
    private var menuArray:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(rgba:"#1D1D1D")
        menuArray = [ getFontName("icon-m-watch")+"  Discover", getFontName("icon-c-bluetouth")+"  Workshop",getFontName("icon-m-shopping-cart")+"  Friends",getFontName("icon-m-user")+"  Friends", getFontName("icon-m-group")+"  Group", getFontName("icon-m-favorite")+"  Favorite", getFontName("icon-m-return")+"  Login in"]

       setTableView()
    }
  
    func setTableView(){
        
        tableView = UITableView(frame: CGRectMake(0,0,250,SCREEN_HEIGHT), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.backgroundColor = UIColor(rgba:"#1D1D1D")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        view.addSubview(tableView)
        
        
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Discover:
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController:DiscoverViewController()), close: true)
        case .WorkShop:
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController:WorkShopViewController()), close: true)
        case .Java:
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController:FriendViewController()), close: true)
        case .Go:
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController:DiscoverViewController()), close: true)
        case .NonMenu:
            self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController:DiscoverViewController()), close: true)
        }
   }

}


extension MenuViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(rgba:"#1D1D1D")
        return view
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 140
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuArray.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            
            cell = UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell?.backgroundColor = UIColor(rgba:"#1D1D1D")
            cell?.textLabel?.font = UIFont(name:"microduino-icon", size:17)
            cell?.textLabel?.text = menuArray[indexPath.row] as? String
            cell?.textLabel?.textAlignment = NSTextAlignment.Right
            cell!.indentationLevel = 3
            cell!.indentationWidth = 25
            cell?.textLabel?.textColor = UIColor.whiteColor()
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.deselectRowAtIndexPath(indexPath, animated:true)
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }


}