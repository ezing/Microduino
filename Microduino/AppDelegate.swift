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

        // 友盟默认网页新浪微博分享
        UMSocialData.setAppKey("56f8d516e0f55af048001f43")
        
        // 微信
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret:"db426a9829e4b49a0dcac7b4162da6b6", url:"http://www.umeng.com/social")
        // QQ
        UMSocialQQHandler.setQQWithAppId("100424468", appKey:"c7394704798a158208a74ab60104f0ba", url:"http://www.umeng.com/social")
    
    
        UMSocialFacebookHandler.setFacebookAppID("506027402887373", shareFacebookWithURL:"http://www.umeng.com/social")

//        UMSocialTwitterHandler.setTwitterAppKey("fB5tvRpna1CKK97xZUslbxiet", withSecret:"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K")
        
        UMSocialInstagramHandler.openInstagramWithScale(false,paddingColor:UIColor.blackColor());
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
     
        let leftViewController = MenuViewController()
        let centerViewController = DiscoverViewController()
        let centerNavigationController = UINavigationController(rootViewController: centerViewController)
        let leftNavigationController = UINavigationController(rootViewController: leftViewController)
        
        drawerController = MMDrawerController(centerViewController: centerNavigationController, leftDrawerViewController: leftNavigationController)
        drawerController.maximumRightDrawerWidth =  SCREEN_WIDTH * 0.80
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.None
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        self.window!.addSubview(drawerController.view)
        self.window?.rootViewController = drawerController
        self.window?.makeKeyAndVisible()
       
        
        return true
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

