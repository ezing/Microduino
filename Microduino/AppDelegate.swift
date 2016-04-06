//
//  AppDelegate.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import MMDrawerController
import SwiftDDP
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerController:MMDrawerController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

//        ShareSDK.registerApp("ShareSDKAppKey")
//        //新浪微博
//        ShareSDK.connectSinaWeiboWithAppKey("4071914616", appSecret: "273f52407df87a15cbe06840c64cc0d2", redirectUri: "http://www.weibo.com/balancea")
//        //豆瓣
//        ShareSDK.connectDoubanWithAppKey("02e0393e2cfbecb508a0abba86f3c61f", appSecret: "9a000e648fd0cbce", redirectUri: "http://www.ijilu.com")
//        //QQ空间
//        ShareSDK.connectQZoneWithAppKey("1103527931", appSecret:"WEKkOPW0NJkc1cwS", qqApiInterfaceCls: QQApiInterface.classForCoder(), tencentOAuthCls: TencentOAuth.classForCoder())
//        //QQ
//        ShareSDK.connectQQWithAppId("1103527931", qqApiCls:QQApiInterface.classForCoder())
//        //链接微信
//        ShareSDK.connectWeChatWithAppId("wx5f09f3b56fd1faf7", wechatCls: WXApi.classForCoder())
//        //微信好友
//        ShareSDK.connectWeChatSessionWithAppId("wx5f09f3b56fd1faf7", wechatCls:WXApi.classForCoder())
//        //微信朋友圈
//        ShareSDK.connectWeChatTimelineWithAppId("wx5f09f3b56fd1faf7", wechatCls: WXApi.classForCoder())
//        ShareSDK.connectRenRenWithAppKey("3899f3ffa97544a3a6767ce3d7530142", appSecret: "4a9df27a701742c09d05dbb52ef1483a")

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        let page = GuideViewController()
//        
//        window!.rootViewController = page
//        window!.makeKeyAndVisible()
//       
        let leftViewController = MenuViewController()
        let centerViewController = DiscoverViewController()
        let centerNavigationController = UINavigationController(rootViewController: centerViewController)
        let leftNavigationController = UINavigationController(rootViewController: leftViewController)
        
        drawerController = MMDrawerController(centerViewController: centerNavigationController, leftDrawerViewController: leftNavigationController)
        drawerController.maximumRightDrawerWidth =  SCREEN_WIDTH * 0.80
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        self.window!.addSubview(drawerController.view)
        self.window?.rootViewController = drawerController
        self.window?.makeKeyAndVisible()
       
        showGuidePage()
        
        return true
    }

    func showGuidePage()
    {
        
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
      
    }

    func applicationWillEnterForeground(application: UIApplication) {
      
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
       
    }


}

