//
//  YhDefine.swift
//  Microduino
//
//  Created by harvey on 16/3/22.
//  Copyright © 2016年 harvey. All rights reserved.
//

import Foundation

let loadingTip = "加载中..."

func YhLog(message:String, function:String = #function)
{
    #if DEBUG
        print("Log:\(message),\(function)")
    #else
        
    #endif
}

// MARK: - MARGIN
let UI_MARGIN_5 : CGFloat = 5
let UI_MARGIN_10 : CGFloat = 10
let UI_MARGIN_15 : CGFloat = 15
let UI_MARGIN_20 : CGFloat = 20