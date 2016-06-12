//
//  Home_Cell.swift
//  Microduino
//
//  Created by harvey on 16/6/2.
//  Copyright © 2016年 harvey. All rights reserved.
//
import UIKit

class Home_Cell: UICollectionViewCell {
    
    var imgView : UIImageView?
    var titleLabel:UILabel?
    var model : FriendModel? {
        willSet {
            
            self.model = newValue
        }
        didSet {
            if model != nil {
                let imageUrl = NSURL(string:(self.model?.author_avator?.URLFormat())!)
                self.imgView!.yy_setImageWithURL(imageUrl, placeholder: nil)
                titleLabel?.text = model?.author_name
                
            }
    }}
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        imgView = UIImageView(frame: CGRectMake(0, -10, (SCREEN_WIDTH-100)/4, (SCREEN_WIDTH-100)/4))
        imgView?.layer.cornerRadius = ((SCREEN_WIDTH-100)/8)
        imgView?.layer.masksToBounds = true
        self .addSubview(imgView!)
        
        titleLabel = UILabel(frame: CGRectMake(10, CGRectGetMaxY(imgView!.frame)-12, (SCREEN_WIDTH-100)/4, 50))
        titleLabel?.font = UI_FONT_14
        titleLabel?.textColor = UIColor.blackColor()
        self .addSubview(titleLabel!)
        
     }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}