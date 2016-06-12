//
//  YHWebViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import WebKit

class YHWebViewController: UIViewController {

    var url: String?
    private var webView: UIWebView?  ///ios8 一下的支持
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        if self.respondsToSelector(Selector("setAutomaticallyAdjustsScrollViewInsets:")) {
            
            self.automaticallyAdjustsScrollViewInsets = true
        }
        if let _ = url {

            if NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0)) {
                self.initWkWebView()
                
            }else {
                
                self.webView = UIWebView(frame:self.view.bounds)
                self.view.addSubview(self.webView!)
            }
        }else {
            
            self.showError("页面出错！")
        }

        
         self.initNavBar()
         self.initProgressView()
    }
    
    init(url: String?) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.url = url
        
    }
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private lazy var YHWebView:WKWebView = {
        
        let YHWebView = WKWebView(frame: self.view.bounds)
        YHWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        YHWebView.navigationDelegate = self
        YHWebView.allowsBackForwardNavigationGestures = true
        YHWebView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.New, context: nil)
        YHWebView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.New, context: nil)
        return YHWebView
        
    }()
    
    private lazy var progressView:UIProgressView = {
        
        let progressView = UIProgressView(frame:CGRectMake(0,0,SCREEN_WIDTH,5.0))
        progressView.progressViewStyle = UIProgressViewStyle.Bar
        progressView.hidden = true
        progressView.trackTintColor = UIColor.clearColor()
        progressView.progressTintColor = UIColor(rgba:"#AAFF18")
        return progressView
    }()
    
    private lazy var backBtn:UIButton = {
        
        let backBtn = UIButton(frame:CGRectMake(0,25,30,30))
        backBtn.setImage(UIImage(named: "ico_back"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: #selector(backAction), forControlEvents: UIControlEvents.TouchUpInside)
        return backBtn
    }()
    
    private lazy var closeBtn:UIButton = {
        
        let closeBtn = UIButton(frame:CGRectMake(0, 0, 40, 40))
        closeBtn.setTitle("关闭", forState: UIControlState.Normal)
        closeBtn.setTitleColor(UIColor(rgba:"#AAFF18"), forState: UIControlState.Normal)
        closeBtn.titleLabel?.font = UI_FONT_16
        closeBtn.addTarget(self, action: #selector(closeAction), forControlEvents: UIControlEvents.TouchUpInside)
        return closeBtn
    }()
    
    private lazy var errorLabel:UILabel = {
        let errorLabel = UILabel(frame:CGRectMake(0,SCREEN_HEIGHT/2 - 10,SCREEN_WIDTH, 20))
        errorLabel.font = UIFont.systemFontOfSize(17)
        errorLabel.textAlignment = NSTextAlignment.Center
        errorLabel.textColor = UIColor.redColor()
        return errorLabel
    }()
    deinit {
            self.YHWebView.removeObserver(self, forKeyPath: "estimatedProgress")
            self.YHWebView.removeObserver(self, forKeyPath: "title")
        }
}

extension YHWebViewController{

    
    //MARK: ---------- 初始话WkWebView -----------
    func initWkWebView() {
        
        self.view.addSubview(self.YHWebView)
        self.YHWebView.loadRequest(NSURLRequest(URL: NSURL(string: self.url!)!))
        
    }
    //MARK: ---------- 初始化progressView ----------
    func initProgressView() {
        
        self.view.addSubview(self.progressView)
    }
    
    //MARK: ---------- 初始化导航 ----------
    
    func initNavBar() {
        
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.leftBarButtonItem = nil
        
        let backItem = UIBarButtonItem(customView: backBtn)
        let closeItem = UIBarButtonItem(customView: closeBtn)
        
        if  self.YHWebView.canGoBack {
            self.navigationItem.leftBarButtonItems = [backItem,closeItem]
        }else {
            self.navigationItem.leftBarButtonItem = backItem
        }
        
    }
    //MARK:----------进度的监听方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "estimatedProgress" {
            
            if object as! NSObject == self.YHWebView {
                print(self.YHWebView.estimatedProgress)
                if self.YHWebView.estimatedProgress > 0.2 {
                    
                    self.progressView.setProgress(Float(self.YHWebView.estimatedProgress), animated: true)
                    
                    if self.YHWebView.estimatedProgress >= 1.0 {
                        
                        self.progressView.setProgress(0.99999, animated: true)
                        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.Autoreverse, animations: { () -> Void in
                            self.progressView.hidden = true
                            self.progressView.setProgress(0.0, animated: false)
                        }) { (finish) -> Void in
                            
                        }
                    }
                    
                }
                
                
            }else {
                
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            }
        }else if keyPath == "title" {
            
            if object as! NSObject == self.YHWebView {
                
                if  self.YHWebView.canGoForward {
                    
                    self.initNavBar()
                }
                
            }else{
                
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
                
            }
        }else {
            
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    //MARK: ----------- 私有方法 ----------
    func showError(message: String?) {
        
        hideError()
        errorLabel.text = message
        self.view.addSubview(errorLabel)
    }
    
    func hideError() {
        
        errorLabel.removeFromSuperview()
    }
 
    //MARK: --------- private func ----------
    func closeAction() {
        
        self.webView = nil
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func backAction() {
        
        if self.YHWebView.canGoBack {
            
            self.YHWebView.goBack()
        }else {
            
            self.closeAction()
        }
        
    }
    
}

extension YHWebViewController:WKNavigationDelegate{

  
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.progressView.hidden = false
        self.progressView.setProgress(0.2, animated: true)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        
        
        
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        
        self.progressView.hidden = true
    }
}