//
//  DiscoverDetailViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/21.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import SwiftDDP

class DiscoverDetailViewController: UIViewController,XMFindAppDetailToolViewDelegate, XMHomeDetailCenterViewDelegate,UIScrollViewDelegate {

    override func viewDidLoad() {
 
        self.view.backgroundColor = UIColor(rgba:"#F2F2F6")
        self.automaticallyAdjustsScrollViewInsets = false
   
        let url = NSBundle.mainBundle().URLForResource("text", withExtension:"html")
        
        let htmlString = try?  String(contentsOfURL:url!)
        
        centerView.model = htmlString
        self.view.addSubview(centerView)
        
        
        toolBarView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:64)
        toolBarView.backgroundColor = UIColor(rgba:"#F2F2F6")
        self.view.addSubview(toolBarView)
        
        returnBtn.frame = CGRect(x: 20, y: 27, width: 30, height: 30)
        self.view.addSubview(returnBtn)
        
       
        
        
//
//        let dict: [String: AnyObject] = ["articleId": "QhhChpm5yq8QMny49",]
//
//        Meteor.connect("wss://w.microduino.cn/websocket") {
//            
//            Meteor.call("mobile/article_show", params:[dict], callback: { (result, error) in
//                
//                print("--------articleshow-----------",error,result)
//                
//                if((error) != nil){
//                    
//                    self.showNetWorkErrorView()
//                    self.hiddenProgress()
//                    
//                }else{
//                    
//                    self.hiddenProgress()
//                
//                }})
//            }
    }
    
    
    func homeDetailCenterViewBottomShareDidClick(centerView: DiscoverCenterView) {
        
    }
    
    func homeDetailCenterView(centerView: DiscoverCenterView, returnButtonDidClick returnButton: UIButton) {
        
    }
    
    //MARK:- CenterViewDelegate
    func FindAppDetailCenterViewReturnBtnDidClick() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func XMFindAppDetailToolViewDownloadBtnClick() {
      
//        //定制分享信息
//        let pic = NSBundle.mainBundle().pathForResource("ShareSDK", ofType: "jpg")
//        
//        let publishContent : ISSContent =
//            ShareSDK.content("swift调用分享文字",
//                             defaultContent:"默认分享内容，没内容时显示",
//                             image:ShareSDK.imageWithPath(pic),
//                             title:"提示",
//                             url:"http://www.mob.com",
//                             description:"这是一条测试信息",
//                             mediaType:SSPublishContentMediaTypeNews)
//        
//        ShareSDK.showShareActionSheet(nil, shareList: nil, content: publishContent, statusBarTips: false, authOptions: nil, shareOptions: nil) { (ShareType, state:SSResponseState, statusInfo :ISSPlatformShareInfo!, error:ICMErrorInfo!, end:Bool) -> Void in
//            
//            if (state.rawValue == SSResponseStateSuccess.rawValue){
//                print("分享成功")
//            }else if (state.rawValue == SSResponseStateFail.rawValue){
//                print("分享失败,错误码:\(error.errorCode()),错误描述:\(error.errorDescription())")
//            }else if (state.rawValue == SSResponseStateCancel.rawValue){
//                print("分享取消")
//            }
//            
//        }
    }
    
    func XMFindAppDetailToolViewShareBtnClick() {
       
     
        
    }
    
    //MARK:- CenterViewDelegate
    func returnBtnDidClick(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    // scrollview
    private lazy var centerView : DiscoverCenterView = {
        let centerView : DiscoverCenterView = DiscoverCenterView()
        centerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        centerView.delegate = self
        centerView.centerDelegate = self
        return centerView
    }()
    
    private lazy var toolBarView : DiscoverDetailToolView = {
        let toolBarView : DiscoverDetailToolView = DiscoverDetailToolView.toolView()
        toolBarView.delegate = self
        return toolBarView
    }()
    
    // 返回按钮
    private lazy var returnBtn : UIButton = {
        let returnBtn : UIButton = UIButton()
        returnBtn.addTarget(self, action:#selector(DiscoverDetailViewController.returnBtnDidClick(_:)), forControlEvents: .TouchUpInside)
        returnBtn.setImage(UIImage(named: "detail_icon_back_normal"), forState: .Normal)
        returnBtn.setImage(UIImage(named: "detail_icon_back_pressed"), forState: .Highlighted)
        return returnBtn
    }()

    // 描述(p)
    private func createPTitleLabel() -> YYLabel {
        let contentLabel : YYLabel = YYLabel()
        contentLabel.displaysAsynchronously = true
        contentLabel.font = UI_FONT_16
        contentLabel.textColor = UIColor.darkGrayColor()
        contentLabel.numberOfLines = 0
        return contentLabel
    }
    
}