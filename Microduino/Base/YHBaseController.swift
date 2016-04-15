//
//  YHBaseController.swift
//  Microduino
//
//  Created by harvey on 16/3/22.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class YHBaseController: UIViewController {

    override func viewDidLoad() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,action:#selector(keyboardHide))
        tapGestureRecognizer.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func keyboardHide(){
    
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    
    }
    
    
}
