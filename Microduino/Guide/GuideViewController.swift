//
//  Guide1ViewController.swift
//  Microduino
//
//  Created by harvey on 16/4/6.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

class GuideViewController: VideoSplashViewController {

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
      override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        setupVideoBackground()
        self.view.addSubview(LoginButton)
        
    }

    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    private lazy var LoginButton:UIButton = {
        
        let LoginButton = UIButton(frame: CGRectMake(20,SCREEN_HEIGHT-200,SCREEN_WIDTH-40,40))
        LoginButton.setTitle("Login", forState: UIControlState.Normal)
        LoginButton.titleLabel?.font = UI_FONT_20
        LoginButton.addTarget(self, action:#selector(goLogin), forControlEvents: UIControlEvents.TouchUpInside)
        LoginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return LoginButton
    }()
    
    func goLogin(){
    
        self.navigationController?.pushViewController(LoginViewController(), animated:true)
    }
    
    func setupVideoBackground() {
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("mCookie", ofType: "mp4")!)
        self.videoFrame = view.frame
        self.fillMode = .ResizeAspectFill
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 12.0
        self.alpha = 0.7
        self.backgroundColor = UIColor.blackColor()
        self.contentURL = url
       
        
    }

}
