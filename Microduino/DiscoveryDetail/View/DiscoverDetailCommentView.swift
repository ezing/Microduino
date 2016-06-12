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
class DiscoverDetailCommentView: UIView {

    var delegate : DiscoverCommentViewDelegate?
    var model : ArticleModel? {
        willSet {
            
            self.model = newValue
        }
        didSet {
            
            if model != nil {
                favcount.text = "\((model?.favcount)! as Int)"
                if(model?.isFavorite == 0){
                
                    starView.fillView! .transform = CGAffineTransformMakeScale(CGFloat(FLT_MIN), CGFloat(FLT_MIN))
                }else{
                
                    starView.fillView?.transform = CGAffineTransformMakeScale(1,1)
                    
                }
              
                
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(centerView)
        centerView.addSubview(commentButton)
        centerView.addSubview(starView)
        centerView.addSubview(favcount)
        centerView.addSubview(shareButton)
        
    }
    
    private lazy var commentButton:UIButton = {
    
        let commentButton  = UIButton(frame:CGRectMake(10,5,200,30))
        commentButton.layer.borderWidth = 0.5
        commentButton.layer.borderColor = UIColor(rgba:"#C8CECD").CGColor
        commentButton.setTitle("  添加你的评论", forState: UIControlState.Normal)
        commentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        commentButton.titleLabel?.font = UI_FONT_14
        commentButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        commentButton.addTarget(self, action:#selector(sendComments), forControlEvents: UIControlEvents.TouchUpInside)

        return commentButton
    
    }()
    
    private lazy var shareButton:UIButton = {
        let maskImage = UIImage(named:"btn_link_fill")
        let lineImage = UIImage(named:"btn_link_line")
        let shareButton = UIButton()
        shareButton.frame = CGRectMake(SCREEN_WIDTH-50,12,maskImage!.size.width, maskImage!.size.height)
        shareButton.setImage(UIImage(named:"share"), forState: UIControlState.Normal)
        shareButton.addTarget(self, action:#selector(shareContent), forControlEvents: UIControlEvents.TouchUpInside)
        return shareButton
    }()
    
    private lazy var starView:YHStarView = {
        
        let maskImage = UIImage(named:"like1_icons")
        let lineImage = UIImage(named:"like_icons")
        let starView = YHStarView()
        starView.frame = CGRectMake(SCREEN_WIDTH-100,12, maskImage!.size.width, maskImage!.size.height)
        starView.tintColor = UIColor.redColor()
        starView.delegate = self
        starView.maskImage(maskImage!)
        starView.borderImage(lineImage!)
        starView.fillColor(UIColor(red:0.94,green: 0.27,blue: 0.32,alpha: 1))
        return starView
    }()
    
    internal lazy var favcount:UILabel = {

        let favcount = UILabel()
        favcount.font = UI_FONT_10
        favcount.frame = CGRectMake(SCREEN_WIDTH-78,0,60,30)
        return favcount
    }()
    
    private lazy var centerView:UIView =  {
   
        let centerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width:SCREEN_WIDTH, height: 40))
        centerView.backgroundColor = UIColor.whiteColor()
        centerView.layer.borderWidth = 0.5
        centerView.layer.borderColor = UIColor(rgba:"#F2F2F6").CGColor
        return centerView
    }()
    
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
extension DiscoverDetailCommentView:YHStarViewDelegate{


    func sendStarValue(value: Int) {
    
        self.delegate?.DiscoverPriaseBtnClick(value)
    }
    

}
