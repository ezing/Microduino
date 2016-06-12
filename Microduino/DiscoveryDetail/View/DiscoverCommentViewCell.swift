//
//  DiscoverCommentViewCell.swift
//  Microduino
//
//  Created by harvey on 16/4/11.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import YYText
import YYWebImage
class DiscoverCommentViewCell: UITableViewCell {

    var model : CommentModel? {
        willSet {
            
            self.model = newValue
        }
        didSet {
            
            if model != nil {
               
                self.comment_date.text = model?.comment_date
                self.comment_name.text = model?.comment_name
                self.comment_avator.kf_setImageWithURL(NSURL(string: (model?.comment_avator)!)!, placeholderImage:nil)
                
                let attributStr : NSMutableAttributedString = NSMutableAttributedString(string: (model?.comment_content)!)
                attributStr.setAttributes([NSFontAttributeName : UI_FONT_14], range: NSMakeRange(0,  (model?.comment_content)!.length))
                attributStr.yy_color = UIColor.darkGrayColor()
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 5.0
                attributStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0,  (model?.comment_content)!.length))
                let textLayout = YYTextLayout (containerSize: CGSize(width:commentBg.width-2*UI_MARGIN_10, height: CGFloat.max), text: attributStr)
                commentLabel.size = textLayout!.textBoundingSize
                commentLabel.textLayout = textLayout
                // 设置frame
                self.commentBg.height = CGRectGetMaxY(commentLabel.frame)+UI_MARGIN_10
                self.height = CGRectGetMaxY(commentBg.frame)+UI_MARGIN_10
          

            }
        }
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor =  UIColor(rgba:"#C8CECD")
        createUI()
        
    }
    
    
    func createUI(){
        
        commentBg.frame = CGRectMake(UI_MARGIN_10, CGRectGetMaxY(comment_name.frame)+UI_MARGIN_25, SCREEN_WIDTH-2*UI_MARGIN_10, 20)
        commentLabel.frame = CGRectMake(UI_MARGIN_10, 15, commentBg.width-2*UI_MARGIN_10, 20)
        
        self.addSubview(comment_date)
        self.addSubview(comment_avator)
        self.addSubview(comment_content)
        self.addSubview(comment_name)
        self.addSubview(commentBg)
        commentBg.addSubview(commentLabel)
        

    }
    
    private lazy var comment_avator:UIImageView = {
    
        let  comment_avator = UIImageView(frame:CGRectMake(10,20,50,50))
        comment_avator.layer.masksToBounds = true
        comment_avator.layer.cornerRadius = 25
        return comment_avator
    }()
    
    private lazy var comment_name:UILabel = {
    
        let comment_name = UILabel(frame:CGRectMake(100,20,100,30))
        return comment_name
    }()
    
    private lazy var comment_content:UILabel = {
    
        let comment_content = UILabel(frame:CGRectMake(100,60,SCREEN_WIDTH-100,30))
        comment_content.font = UI_FONT_14
        comment_content.layer.cornerRadius = 5
        comment_content.layer.masksToBounds = true
        return comment_content
    }()
    
    private lazy var comment_date:UILabel =  {
        
       let comment_date = UILabel(frame:CGRectMake(100,45,200,30))
        comment_date.font = UI_FONT_10
        return comment_date
    
    }()
    
    // 评论背景
    private lazy var commentBg : UIImageView = {
        let commentBg : UIImageView = UIImageView()
        
        let bgImg : UIImage = UIImage(named: "detail_comment_bg")!
        let stretchWidth = bgImg.size.width*0.8
        let stretchHeight = bgImg.size.height*0.4
        commentBg.image = bgImg.resizableImageWithCapInsets(UIEdgeInsets(top: stretchHeight, left: stretchWidth, bottom: stretchHeight, right: bgImg.size.width*0.1), resizingMode: UIImageResizingMode.Stretch)
        commentBg.layer.cornerRadius = 3
        commentBg.layer.masksToBounds = true
        return commentBg
    }()
    
    // 评论了内容
    private lazy var commentLabel : YYLabel = {
        var commentLabel : YYLabel = YYLabel()
        commentLabel.font = UI_FONT_10
        commentLabel.textColor = UIColor.darkGrayColor()
        commentLabel.numberOfLines = 0
        return commentLabel
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
