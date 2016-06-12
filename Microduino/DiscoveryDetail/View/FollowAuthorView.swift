//
//  FollowAuthorView.swift
//  Microduino
//
//  Created by harvey on 16/4/20.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
protocol FollowAuthorViewDelegate {
    func FollowBtnClick(sender:UIButton)
}
class FollowAuthorView: UIView {

    var delegate : FollowAuthorViewDelegate?
    var model : ArticleModel? {
        willSet {
            
            self.model = newValue
        }
        didSet {
                self.author_name.text = model!.author_name
                self.author_avator.kf_setImageWithURL(NSURL(string: (model?.author_avator)!)!, placeholderImage:nil)
            if(model?.isFollowingAuthor != 0){
            
                followButton.backgroundColor = UIColor.clearColor()
                followButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                followButton.setTitle("已关注", forState: UIControlState.Normal)
                followButton.tag = 1

                
            }
        }
    
    }

    override init(frame: CGRect) {
        
        super.init(frame:frame)
        self.backgroundColor = UIColor(rgba:"#C8CECD")
        
        self.addSubview(author_avator)
        self.addSubview(author_name)
        self.addSubview(followButton)
        
    }

    private lazy var author_avator:UIImageView = {
    
        let  author_avator = UIImageView(frame:CGRectMake(10,10,34,34))
        author_avator.layer.masksToBounds = true
        author_avator.layer.cornerRadius = 17
        return author_avator
    }()
    
    private lazy var author_name:UILabel = {
    
        let author_name = UILabel(frame:CGRectMake(50,12,100,30))
        author_name.font = UI_FONT_16
        return author_name
    }()
    
    private lazy var followButton:UIButton = {
    
        let followButton = UIButton(frame:CGRectMake(SCREEN_WIDTH-70,15,60,30))
        followButton.backgroundColor = UIColor(rgba:"#1D1D1D")
        followButton.setTitle(" 关注", forState: UIControlState.Normal)
        followButton.setTitleColor(UIColor(rgba:"#AAFF18"), forState: UIControlState.Normal)
        followButton.tag = 0
        followButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 3
        followButton.layer.borderWidth = 0.5
        followButton.layer.borderColor = UIColor(rgba:"#DBDBE0").CGColor
        followButton.titleLabel?.font = UI_FONT_14
        followButton.addTarget(self, action:#selector(followBtnDidClick), forControlEvents: UIControlEvents.TouchUpInside)
        return followButton
    }()
    
    func followBtnDidClick(sender:UIButton){
    
        delegate?.FollowBtnClick(sender)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
