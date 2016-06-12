//
//  String+XM.swift
//  BeautifulApp
//
//  Created by 梁亦明 on 15/11/10.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import Foundation

extension String {
    var length : Int {return self.characters.count}
    var convert: NSString { return (self as NSString) }
    
    init(htmlEncodedString: String) {
        do {
            let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
            let attributedOptions : [String: AnyObject] = [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
            ]
            let attributedString = try NSAttributedString(data: encodedData,
                                                          options: attributedOptions, documentAttributes: nil)
            self.init(attributedString.string)
        } catch {
            fatalError("Unhandled error: \(error)")
        }
    }

    func toHtmlEncodedString() -> String {
        var result:String = "";
        for scalar in self.utf8 {
            //将十进制转成十六进制，不足4位前面补0
            let tem = String().stringByAppendingFormat("%04x",scalar)
            result += "\\u"+"{\(tem)}";
        }
        return result
    }
    
    
    func utf8encodedString() ->String {
            var arr = [UInt8]()
            arr += self.utf8
            return String(bytes: arr,encoding: NSUnicodeStringEncoding)!
    }
    
    func URLFormat()->String{
    
      return  stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    
    }
    func convertToUTF8() -> String {
       
      return  stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLHostAllowedCharacterSet())!
    }
    
    
    
    
    func getImageSizeWithURL() -> CGSize {
        // 获取 _ 的位置
        let firstIndex : NSRange = (self as NSString).rangeOfString("_")
        let imgType : [String] = [".JPG",".jpg",".JPEG",".jpeg",".PNG",".png",""]
        
        var currType = imgType.last
        var typeRange : NSRange!
        for type in imgType {
            typeRange = (self as NSString).rangeOfString(type)
            if typeRange.location < 100 {
                currType = type
                break;
            }
        }
        var sizeString = self
        guard currType != "" else {
            print ("图片类型错误:\(self)")
            return CGSizeZero
        }
        
        sizeString = (self as NSString).substringWithRange(NSMakeRange(firstIndex.location+1, typeRange.location - firstIndex.location-1))
        
        let size = sizeString.componentsSeparatedByString("x")
        let widthFormatter = NSNumberFormatter().numberFromString(size.first!)
        let heightFormatter = NSNumberFormatter().numberFromString(size.last!)
        
        guard let _ = widthFormatter else {
            return CGSizeZero
        }
        guard let _ = heightFormatter else {
            return CGSizeZero
        }
        
        var width = CGFloat(widthFormatter!)
        var height = CGFloat(heightFormatter!)
        if width > SCREEN_WIDTH - 20 {
            width = SCREEN_WIDTH - 20
            height = width * height / CGFloat(widthFormatter!)
        }
        
        return CGSize(width: CGFloat(width), height: CGFloat(height))
        
    }
    
    //返回一个去掉字符串中的HTML代码的新的字符串
    mutating func filterHTML() -> String?{
        
        let scanner = NSScanner(string: self)
        
        var text: NSString?
        
        while !scanner.atEnd {
            
            scanner.scanUpToString("<", intoString: nil)
            
            scanner.scanUpToString(">", intoString: &text)
            
            self = self.stringByReplacingOccurrencesOfString("\(text == nil ? "" : text!)>", withString: "")
            
        }
        return self
        
    }
    
    
    func random(min:UInt32,max:UInt32)->UInt32{
        return  arc4random_uniform(max-min)+min
    }
    
    func randomString(len:Int)->String{
        let min:UInt32=33,max:UInt32=127
        var string=""
        for _ in 0..<len{
            string.append(UnicodeScalar(random(min,max:max)))
        }
        return string
        
    }

}
