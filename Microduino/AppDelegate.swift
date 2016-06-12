//
//  AppDelegate.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import SwiftDDP
import Haneke
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    var guideViewController = GuideViewController()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        // Optional: configure GAI options.
        let gai = GAI.sharedInstance()
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
        
        
        
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
     //   NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Login), name:"loginMark", object: nil)

        reloadNativeData()

        let firstItemIcon:UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .Compose)
        let firstItem = UIMutableApplicationShortcutItem(type: "1", localizedTitle: "写文章", localizedSubtitle: nil, icon: firstItemIcon, userInfo: nil)
        application.shortcutItems = [firstItem]
        
        
        UMSocialData.setAppKey("56f8d516e0f55af048001f43")
        
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("2519797811", secret:"d703272f1f2df1f7115a14fe1a86e0d7", redirectURL: "http://sns.whalecloud.com/sina2/callback")
    
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret:"db426a9829e4b49a0dcac7b4162da6b6", url:"http://www.umeng.com/social")
        UMSocialQQHandler.setQQWithAppId("100424468", appKey:"c7394704798a158208a74ab60104f0ba", url:"http://www.umeng.com/social")
        UMSocialFacebookHandler.setFacebookAppID("926545990746063", shareFacebookWithURL:"http://www.umeng.com/social")
        UMSocialTwitterHandler.openTwitter()
        UMSocialTwitterHandler.setTwitterAppKey("wGeZVOFRlt1YTyIBan2RSeK4e", withSecret:"Q4Ap5JWPl2ExOzwuDyKBqVviqWvUHatg747GSFu9Xn4buHuQsU")
    
        UMSocialInstagramHandler.openInstagramWithScale(false,paddingColor:UIColor.blackColor())
    
     
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        let centerViewController = DiscoverViewController()
        let centerNavigationController = UINavigationController(rootViewController: centerViewController)
        let slideMenuController = SlideMenuController(mainViewController: centerNavigationController, leftMenuViewController: MenuViewController())
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()

        return true
    }

//    func Login(){
//
//        self.window?.rootViewController = drawerController
//    
//    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        if shortcutItem.type == "1" { //写文章
          
            NSNotificationCenter.defaultCenter().postNotificationName("writeArticle", object: nil)
        }
    }
    
       
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        let  result = UMSocialSnsService.handleOpenURL(url)
        return result
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool{
       
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
      
     guideViewController.pauseVideo()
       
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
      guideViewController.playVideo()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
       
    }

    func reloadNativeData(){
        
        let icons = NSMutableDictionary()
        icons.setValue("\u{0000e90a}", forKey:"icon-c-usb-ttl")
        icons.setValue("\u{0000e90c}", forKey:"icon-c-usb-host")
        icons.setValue("\u{0000e90d}", forKey:"icon-c-wifi")
        icons.setValue("\u{0000e90e}", forKey:"icon-c-2dot4g")
        icons.setValue("\u{0000e90f}", forKey:"icon-c-zig-bee")
        icons.setValue("\u{0000e910}", forKey:"icon-c-nfc")
        icons.setValue("\u{0000e911}", forKey:"icon-c-wiz")
        icons.setValue("\u{0000e912}", forKey:"icon-c-enc")
        icons.setValue("\u{0000e913}", forKey:"icon-c-rs485")
        icons.setValue("\u{0000e915}", forKey:"icon-c-gsm-gprs")
        icons.setValue("\u{0000e916}", forKey:"icon-c-bluetouth")
        icons.setValue("\u{0000e917}", forKey:"icon-c-battery")
        icons.setValue("\u{0000e918}", forKey:"icon-c-gps")
        icons.setValue("\u{0000e919}", forKey:"icon-c-crash")
        icons.setValue("\u{0000e91a}", forKey:"icon-c-tft-screen")
        icons.setValue("\u{0000e91b}", forKey:"icon-c-oled-screen")
        icons.setValue("\u{0000e91c}", forKey:"icon-c-10dof")
        icons.setValue("\u{0000e91d}", forKey:"icon-c-rtc")
        icons.setValue("\u{0000e91e}", forKey:"icon-c-micro-sd")
        icons.setValue("\u{0000e91f}", forKey:"icon-c-amplifier")
        icons.setValue("\u{0000e920}", forKey:"icon-c-temperature")
        icons.setValue("\u{0000e921}", forKey:"icon-c-plush")
        icons.setValue("\u{0000e922}", forKey:"icon-c-lightness")
        icons.setValue("\u{0000e923}", forKey:"icon-c-motor")
        icons.setValue("\u{0000e924}", forKey:"icon-c-stepper")
        icons.setValue("\u{0000e925}", forKey:"icon-c-led")
        icons.setValue("\u{0000e926}", forKey:"icon-c-gray")
        icons.setValue("\u{0000e927}", forKey:"icon-c-ir-receiver")
        icons.setValue("\u{0000e928}", forKey:"icon-c-ir-sensor")
        icons.setValue("\u{0000e929}", forKey:"icon-c-pir")
        icons.setValue("\u{0000e908}", forKey:"icon-c-core")
        icons.setValue("\u{0000e909}", forKey:"icon-c-core-plus")
        icons.setValue("\u{0000e90b}", forKey:"icon-c-usb-core")
        icons.setValue("\u{0000e92a}", forKey:"icon-c-color-led")
        icons.setValue("\u{0000e904}", forKey:"icon-m-help")
        icons.setValue("\u{0000e809}", forKey:"icon-m-confirm")
        icons.setValue("\u{0000e930}", forKey:"icon-trush")
        icons.setValue("\u{0000e830}", forKey:"icon-m-watch")
        icons.setValue("\u{0000e826}", forKey:"icon-m-shopping-cart")
        icons.setValue("\u{0000e82f}", forKey:"icon-m-user")
        icons.setValue("\u{0000e814}", forKey:"icon-m-group")
        icons.setValue("\u{0000e80d}", forKey:"icon-m-favorite")
        icons.setValue("\u{0000e822}", forKey:"icon-m-return")
        
        
        let cache = Shared.dataCache
        cache.set(value:NSKeyedArchiver.archivedDataWithRootObject(icons), key:"icons")
        
    }


}

