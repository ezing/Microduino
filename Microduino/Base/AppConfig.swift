//
//  AppConfig.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 屏幕高宽
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

// MARK: - 字体
let UI_FONT_20 = UIFont.systemFontOfSize(20)
let UI_FONT_16 = UIFont.systemFontOfSize(16)
let UI_FONT_14 = UIFont.systemFontOfSize(14)
let UI_FONT_10 = UIFont.systemFontOfSize(10)

// MARK: - 通知
let NOTIFY_SHOWMENU : String = "NOTIFY_SHOWMENU"
let NOTIFY_HIDDEMENU : String = "NOTIFY_HIDDEMENU"
let NOTIFY_SETUPBG : String = "NOTIFY_SETUPBG"
let NOTIFY_ERRORBTNCLICK : String = "NOTIFY_ERRORBTNCLICK"

// 设置homeview类型 - 用于请求api
let NOTIFY_SETUPHOMEVIEWTYPE : String = "NOTIFY_SETUPHOMEVIEWTYPE"
let NOTIFY_OBJ_TODAY : String = "homeViewTodayType"
let NOTIFY_OBJ_FINDAPP : String = "homeViewFindAppType"
let NOTIFY_OBJ_RECOMMEND : String = "homeViewRecommendType"
let NOTIFY_OBJ_ARTICLE : String = "homeViewArticleViewType"

// 设置menu centreview 类型 - 用于切换centerView
let NOTIFY_SETUPCENTERVIEW : String = "NOTIFY_SETUPCENTERVIEW"

// 默认背景色
let UI_COLOR_APPNORMAL : UIColor = UIColor(red: 54/255.0, green: 142/255.0, blue: 198/155.0, alpha: 1)
let UI_COLOR_BORDER : UIColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)