//
//  DiscoverTableViewCell.swift
//  Microduino
//
//  Created by harvey on 16/3/28.
//  Copyright © 2016年 harvey. All rights reserved.
//


import UIKit
import Kingfisher

class DiscoverTableViewCell:UITableViewCell {
   
    let miniumScale:CGFloat = 0.85;
    var bgView:UIView!
    var titleLabel:UILabel!
    var cover_image:UIImageView!
    var author_avator:UIImageView!
    var author_name:UILabel!
    var author_image:UIImage!
    var model : DiscoverModel? {
        willSet {
           
            self.model = newValue
        }
        didSet {
            
            if model != nil {
            
          let imageUrl = NSURL(string:((model?.cover_image)?.stringByAddingPercentEncodingWithAllowedCharacters( NSCharacterSet.URLQueryAllowedCharacterSet())!)!)
            self.author_avator.kf_setImageWithURL(imageUrl!,placeholderImage: nil,optionsInfo:nil)
            self.cover_image.kf_setImageWithURL(imageUrl!,placeholderImage: nil,optionsInfo:nil)
            self.titleLabel.text = model?.article_title
            self.author_name.text = model?.author_name
             
            }
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createUI()
    }
    
    func createUI(){
    
    
        self.bgView  = UIView(frame:CGRectMake(20,0,SCREEN_WIDTH-40,SCREEN_WIDTH-40))
        self.bgView.backgroundColor = UIColor.whiteColor()
        self.bgView.layer.shadowOffset = CGSizeMake(1,1);
        self.bgView.layer.shadowOpacity = 0.3;
        self.bgView.layer.shadowColor = UIColor.blackColor().CGColor
        self.contentView.addSubview(self.bgView)
        
        cover_image = UIImageView(frame:CGRectMake(0,0,SCREEN_WIDTH-40,SCREEN_WIDTH-140))
        
        titleLabel = UILabel(frame:CGRectMake(20,SCREEN_WIDTH-140,SCREEN_WIDTH-80,44))
        titleLabel.font = UI_FONT_16
        author_avator = UIImageView(frame:CGRectMake(20,SCREEN_WIDTH-100,50,50))
        author_avator.layer.masksToBounds = true
        author_avator.layer.cornerRadius = 25
        author_name = UILabel(frame:CGRectMake(80,SCREEN_WIDTH-100,SCREEN_WIDTH-40,44))
        
        
        self.bgView.addSubview(titleLabel)
        self.bgView.addSubview(cover_image)
        self.bgView.addSubview(author_avator)
        self.bgView.addSubview(author_name)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
  
    override func prepareForReuse() {
        
        super.prepareForReuse();
      
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func transformCell(forScale scale: CGFloat) {
       
    }
}