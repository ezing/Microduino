//
//  TestDiscoverModel.swift
//  Microduino
//
//  Created by harvey on 16/5/19.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class ThemeModels: NSObject, DictModelProtocol {
    var lastdate: String?
    var list: [ThemeModel]?
    
    class func loadThemesData(completion: (data: ThemeModels?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ThemeModels.self) as? ThemeModels
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(ThemeModel.self)"]
    }
}

class ThemeModel: NSObject {
    
    var themeurl: String?
    var img: String?
    var title: String?
    var hasweb: Int = -1
    var keywords: String?
    var id: Int = -1
    var text: String?
    
}



