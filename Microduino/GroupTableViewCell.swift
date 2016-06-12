//
//  DiscoverTableViewCell.swift
//  Microduino
//
//  Created by harvey on 16/3/28.
//  Copyright © 2016年 harvey. All rights reserved.
//


import UIKit
import Kingfisher
import YYWebImage

class GroupTableViewCell:UITableViewCell {
    
    let miniumScale:CGFloat = 0.85;
    var model : GroupModel? {
        willSet {
            
            self.model = newValue
        }
        didSet {
            
            if model != nil {
                
                let imageUrl = NSURL(string:(self.model?.cover_image?.URLFormat())!)
                self.cover_image.yy_setImageWithURL(imageUrl, placeholder: nil)
                self.articleTitle.text = model?.group_name
                self.labelCount.text = getFontName("icon-m-user") + "  "+(model?.memberCount)!
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(rgba:"#C8CECD")
        createUI()
    }
    
    func createUI(){
        
        contentView.addSubview(bgView)
        bgView.addSubview(cover_image)
        bgView.addSubview(author_avator)
        bgView.addSubview(card_tyoe)
        bgView.addSubview(articleTitle)
        bgView.addSubview(write_date)
        bgView.addSubview(contentType)
        bgView.addSubview(labelCount)
        
    }
    
    
    private lazy var bgView:UIView = {
        
        let bgView  = UIView(frame:CGRectMake(20,0,SCREEN_WIDTH-40,SCREEN_WIDTH-40))
        bgView.backgroundColor = UIColor.whiteColor()
        bgView.layer.cornerRadius = 5
        bgView.layer.shadowOffset = CGSizeMake(1,1);
        bgView.layer.shadowOpacity = 0.1;
        bgView.layer.shadowColor = UIColor.blackColor().CGColor
        return bgView
    }()
    
    private lazy var cover_image:UIImageView = {
        
        let cover_image = UIImageView(frame:CGRectMake(0,0,SCREEN_WIDTH-40,(SCREEN_WIDTH-40)/4*3))
        cover_image.backgroundColor = UIColor(rgba:"#F6F6F8")
        let maskPath = UIBezierPath(roundedRect:cover_image.bounds,byRoundingCorners:[.TopLeft,.TopRight],cornerRadii:CGSizeMake(5, 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = cover_image.bounds;
        maskLayer.path = maskPath.CGPath
        cover_image.layer.mask = maskLayer;
        
        return cover_image
    }()
    
    private lazy var author_avator:UIImageView = {
        
        let author_avator = UIImageView(frame:CGRectMake(20,SCREEN_WIDTH-100,50,50))
        author_avator.layer.masksToBounds = true
        author_avator.layer.cornerRadius = 25
        return author_avator
        
    }()
    
    private lazy var contentType:UIImageView = {
        
        let contentType = UIImageView(frame:CGRectMake(SCREEN_WIDTH-90,0,40,50))
        return contentType
        
    }()
    
    private lazy var articleTitle:UILabel = {
        
        let articleTitle = UILabel(frame:CGRectMake(20,SCREEN_WIDTH-100,SCREEN_WIDTH-140,44))
        return articleTitle
    }()
    
    private lazy var write_date:UILabel = {
        
        let write_date = UILabel(frame:CGRectMake(5,((SCREEN_WIDTH-40)/4*3)-30,SCREEN_WIDTH-40,30))
        write_date.shadowColor = UIColor.blackColor()
        write_date.shadowOffset = CGSizeMake(0.5,0.5)
        write_date.textColor = UIColor.whiteColor()
        return write_date
    }()
    
    private lazy var labelCount:UILabel = {
        
        let labelCount = UILabel(frame:CGRectMake(SCREEN_WIDTH-110,SCREEN_WIDTH-100,60,44))
        labelCount.font = UIFont(name:"microduino-icon", size:17)
        return labelCount
    }()
    
    
    private lazy var card_tyoe:UILabel = {
        
        let card_type = UILabel(frame:CGRectMake(80,SCREEN_WIDTH-115,SCREEN_WIDTH-120,44))
        return card_type
    }()
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse();
        
    }
    
    func transformCell(forScale scale: CGFloat) {
        
    }
}