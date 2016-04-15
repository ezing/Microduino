//
//  DiscoverDetailCommentVIew.swift
//  Microduino
//
//  Created by harvey on 16/4/12.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
protocol DiscoverCommentViewDelegate {
    func DiscoverCommentBtnClick()
    func DiscoverPriaseBtnClick(tag:Int)
    func DiscoverShareBtnClick()
    
}
class DiscoverDetailCommentView: UIView,LCStarViewDelegate {

    var  commentButton:UIButton?
    var  praiseButton:UIButton?
    var  shareButton:UIButton?
    var delegate : DiscoverCommentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加blur
        let centerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: 40))
        centerView.backgroundColor = UIColor.whiteColor()
        centerView.layer.borderWidth = 0.5
        centerView.layer.borderColor = UIColor(rgba:"#F2F2F6").CGColor
        self.addSubview(centerView)
        
        commentButton  = UIButton(frame:CGRectMake(10,5,200,30))
        commentButton?.layer.borderWidth = 0.2
        commentButton?.setTitle("  添加你的评论", forState: UIControlState.Normal)
        commentButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        commentButton?.titleLabel?.font = UI_FONT_14
        commentButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        commentButton?.addTarget(self, action:#selector(sendComments), forControlEvents: UIControlEvents.TouchUpInside)
        commentButton?.layer.borderColor = UIColor.grayColor().CGColor
        centerView.addSubview(commentButton!)
        
        let maskImage = UIImage(named:"btn_link_fill")
        let lineImage = UIImage(named:"btn_link_line")
        
        let starView = LCStarView(frame:CGRectMake(SCREEN_WIDTH-110,7, maskImage!.size.width, maskImage!.size.height))
        starView.maskImage = maskImage;
        starView.delegate = self;
        starView.borderImage = lineImage;
        starView.fillColor = UIColor(red:0.94,green: 0.27,blue: 0.32,alpha: 1)
        centerView.addSubview(starView)
        
        let shareButton = UIButton(frame:CGRectMake(SCREEN_WIDTH-50,7,maskImage!.size.width, maskImage!.size.height))
        shareButton.setImage(UIImage(named:"share"), forState: UIControlState.Normal)
        shareButton.addTarget(self, action:#selector(shareContent), forControlEvents: UIControlEvents.TouchUpInside)
        centerView.addSubview(shareButton);
        
        
        
    }
    
    func sendValue(value: Int32) {
   
        self.delegate?.DiscoverPriaseBtnClick(Int(value))
        
    }
    
    func shareContent(){
    
        self.delegate?.DiscoverShareBtnClick()
        
    
    }
    
    func  sendComments(){
    
        self.delegate?.DiscoverCommentBtnClick()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
