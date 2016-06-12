//
//  AppConfig.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import Foundation
import UIKit
import Haneke

var fonticons = NSMutableDictionary()

// MARK: - 屏幕高宽
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

// MARK: - 字体
let UI_FONT_20 = UIFont.systemFontOfSize(20)
let UI_FONT_16 = UIFont.systemFontOfSize(16)
let UI_FONT_14 = UIFont.systemFontOfSize(14)
let UI_FONT_10 = UIFont.systemFontOfSize(10)

// MARK: - MARGIN
let UI_MARGIN_5 : CGFloat = 5
let UI_MARGIN_10 : CGFloat = 10
let UI_MARGIN_15 : CGFloat = 15
let UI_MARGIN_20 : CGFloat = 20
let UI_MARGIN_25 : CGFloat = 25

// MARK: - 通知
let NOTIFY_SHOWMENU : String = "NOTIFY_SHOWMENU"
let NOTIFY_HIDDEMENU : String = "NOTIFY_HIDDEMENU"
let NOTIFY_SETUPBG : String = "NOTIFY_SETUPBG"
let NOTIFY_ERRORBTNCLICK : String = "NOTIFY_ERRORBTNCLICK"

// 默认背景色

public let LightLineColor:UIColor = UIColor(rgba: "#F9F9F9")
public let GrayLineColor:UIColor = UIColor(rgba: "#D8D8D8")
public let TitleGrayCorlor:UIColor = UIColor(rgba: "#A7A7A7")
public let PlaceHolderColor:UIColor = UIColor(rgba: "#B6B6B6")
public let ViewGrayBackGroundColor = UIColor(rgba: "#F5F5F5")
public let HalfBlackTitleColor:UIColor = UIColor(rgba: "#959595")



//webView约束
let HTML_CONSTRAINT:String = "<head><style>img{width:100% !important;}</style><body width=100% style=\"word-wrap:break-word; font-family:Arial\"></head>"

let FOUND_IMG = "function addImgClickEvent() { " +
    "var imgs = document.getElementsByTagName('img');" +
    "for (var i = 0; i < imgs.length; ++i) {" +
    "var img = imgs[i];" +
    "img.onclick = function () {" +
    "window.location.href = 'hyb-image-preview:' + this.src;" +
    "}" +
    "}" +
"}"

public  func getFontName(key:String)->String{
    
    let cache = Shared.dataCache
    cache.fetch(key: "icons").onSuccess { data in
        
        fonticons  = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! NSMutableDictionary
    }
    return fonticons.objectForKey("\(key)") as! String
}
