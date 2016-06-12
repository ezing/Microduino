//
//  CheckEmailAddress+Additions.swift
//  YHAPP
//
//  Created by HeHongwe on 15/12/25.
//  Copyright © 2015年 harvey. All rights reserved.
//

import Foundation


extension NSString {
    
    /**
     返回是否为正确邮箱格式
     */
    func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    /**
     返回是否为有效密码
     */
    func isValidPassword() -> Bool {
        let passwdRegex = "^([a-zA-Z0-9]|[*_ !^?#@%$&=+-]){4,16}$"
        let passwdTest = NSPredicate(format: "SELF MATCHES %@", passwdRegex)
        return passwdTest.evaluateWithObject(self)
    }

    /**
     返回是否为有效手机号
     */
    public enum StringCheck{
        case MobilePhone
        public var regularString:String{
            switch self{
            case .MobilePhone:
                return "^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$"
            }
            
        }
    }
    
    func isValidMobilePhone(string : String , type : StringCheck) -> Bool{
        let stringCheck = type.regularString
        let regextest = NSPredicate(format: "SELF MATCHES %@", stringCheck)
        return regextest.evaluateWithObject(string)
    }
    /**
     返回一个删除掉所有出现target字符串的地方的新的字符串
     
     - parameter target: target 字符串
     
     - returns: 新的字符串
     */
    public func stringByDeletingOccurrencesOfString(target: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: "")
    }
    
    
    /**
     返回一个删除掉指定范围内出现target字符串的地方的新的字符串
     
     - parameter target:  target 字符串
     - parameter options: 字符比较模式
     - parameter range:   范围
     
     - returns: 新的字符串
     */
    public func stringByDeletingOccurrencesOfString(target: String,
                                                    options: NSStringCompareOptions,
                                                    range: NSRange) -> String {
        
        return self.stringByReplacingOccurrencesOfString(target,
                                                         withString: "",
                                                         options: options,
                                                         range: range)
    }
    
    /**
     返回一个在所有出现target字符串的地方之前插入指定字符串的新字符串
     
     - parameter str:  待插入的字符串
     - parameter bstr: target字符串
     
     - returns: 新的字符串
     */
    
    public func stringByInsertString(str:String, beforeOccurrencesOfString target:String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: str + target)
    }
    
    
    
    
    /**
     返回一个删除掉指定范围内所有字符的新的字符串
     
     - parameter range: 范围
     
     - returns: 新的字符串
     */
    
    
    public func stringByDeletingCharactersInRange(range: NSRange) -> String {
        return self.stringByReplacingCharactersInRange(range, withString: "")
    }
    
    
    }