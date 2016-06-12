//
//  LoginViewController.swift
//  Microduino
//
//  Created by harvey on 16/5/4.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit

import UIKit
import QuartzCore

class LoginViewController: YHBaseController {

    //MARK: Global Variables for Changing Image Functionality.
    private var idx: Int = 0
    private let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg"), UIImage(named: "img3.jpg"), UIImage(named: "img4.jpg")]
    
    //MARK: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(imageView)
        self.view.addSubview(backButton)
        self.view.addSubview(loginButton)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        usernameField.alpha = 0;
        passwordField.alpha = 0;
        loginButton.alpha   = 0;
        
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 0.9
            }, completion: nil)
        
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), forControlEvents: UIControlEvents.EditingChanged)
        
        
        // Visual Effect View for background
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark)) as UIVisualEffectView
        visualEffectView.frame = self.view.frame
        visualEffectView.alpha = 0.5
        imageView.image = UIImage(named: "img1.jpg")
        imageView.addSubview(visualEffectView)
        
        
        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        self.loginButton(false)
        
    }
    
    // 菜单
    private lazy var usernameField:UITextField = {
        
        let usernameField = UITextField(frame:CGRectMake(50,180,SCREEN_WIDTH-100,40))
        usernameField.backgroundColor = UIColor(rgba:"#828282")
        usernameField.tintColor = UIColor(rgba:"#AAFF18")
        usernameField.placeholder = "username"
        usernameField.textAlignment = NSTextAlignment.Center
        return usernameField
    }()
    
    // 菜单
    private lazy var passwordField:UITextField = {
        
        let passwordField = UITextField(frame:CGRectMake(50,230,SCREEN_WIDTH-100,40))
        passwordField.backgroundColor = UIColor(rgba:"#828282")
        passwordField.placeholder = "password"
        passwordField.tintColor = UIColor(rgba:"#AAFF18")
        passwordField.textAlignment = NSTextAlignment.Center
        return passwordField
    }()
    
    // 菜单
    private lazy var loginButton:UIButton = {
        
        let loginButton = UIButton(frame: CGRectMake(80,350,SCREEN_WIDTH-160,40))
        loginButton.setTitle("login", forState: UIControlState.Normal)
        loginButton.addTarget(self, action:#selector(buttonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        return loginButton
    }()
    
    // 菜单
    private lazy var backButton:UIButton = {
        
        let backButton = UIButton(frame: CGRectMake(0,30,60,40))
        backButton.setImage(UIImage(named:"ico_back"), forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor(rgba:"#AAFF18"), forState: UIControlState.Normal)
        backButton.addTarget(self, action:#selector(goBack), forControlEvents: UIControlEvents.TouchUpInside)
        return backButton
    }()
    
    // 菜单
    private lazy var imageView:UIImageView = {
        
        let imageView = UIImageView(frame:self.view.bounds)
        return imageView
    }()
    
    func goBack(){
    
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    func loginButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#AAFF18", alpha: 1)
                }, completion: nil)
            loginButton.enabled = true
        }
        func disable(){
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    func changeImage(){
        if idx == backGroundArray.count-1{
            idx = 0
        }
        else{
            idx += 1
        }
        let toImage = backGroundArray[idx];
        UIView.transitionWithView(self.imageView, duration: 3, options: .TransitionCrossDissolve, animations: {self.imageView.image = toImage}, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldDidChange() {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
     func buttonPressed(sender: AnyObject) {
        
        
        NSNotificationCenter.defaultCenter().postNotificationName("loginMark", object: nil)
       // self.performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func signupPressed(sender: AnyObject) {
    }
    
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
}

//Extension for Color to take Hex Values
extension UIColor{
    
    }

