//
//  UIWebView+Extension.swift
//  Microduino
//
//  Created by harvey on 16/4/1.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

extension UIWebView{

    func removeHTMLTags(aString: String) -> String{
        let url = NSBundle.mainBundle().URLForResource("remove", withExtension: "js")
        print(url)
        var js = try! NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding) as String
        
        js = js + "delHtmlTag('\(aString)')"
        let s = self.stringByEvaluatingJavaScriptFromString(js as String)
        
        
        return s!
    }



}