//
//  publishViewController.swift
//  Microduino
//
//  Created by harvey on 16/6/1.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class publishViewController: UIViewController {

    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgba:"#C8CECD")
        
        let leftBarBtn = UIBarButtonItem(title: "  返回", style: .Plain, target: self,
                                         action:#selector(backToPrevious))
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        self.view.addSubview(followButton)
        
    }
    
    
    private lazy var followButton:UIButton = {
        
        let followButton = UIButton(frame:CGRectMake((SCREEN_WIDTH-120)/2,SCREEN_HEIGHT-160,120,40))
        followButton.backgroundColor = UIColor(rgba:"#1D1D1D")
        followButton.setTitle("选择封面图", forState: UIControlState.Normal)
        followButton.setTitleColor(UIColor(rgba:"#AAFF18"), forState: UIControlState.Normal)
        followButton.tag = 0
        followButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 3
        followButton.layer.borderWidth = 0.5
        followButton.layer.borderColor = UIColor(rgba:"#DBDBE0").CGColor
        followButton.titleLabel?.font = UI_FONT_20
        followButton.addTarget(self, action:#selector(publicArticle), forControlEvents: UIControlEvents.TouchUpInside)
        return followButton
    }()
    
    func publicArticle(){
    
    
    }
    
    func backToPrevious(){
    
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
}
