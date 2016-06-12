//
//  YHStarView.swift
//  Microduino
//
//  Created by harvey on 16/4/25.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
protocol YHStarViewDelegate {
   
    func sendStarValue(value:Int)
  
}
class YHStarView:UIView{

    var tap:UITapGestureRecognizer?
    var fillView:UIView?
    var borderImageView:UIImageView?
    var maskLayer:CALayer?
    var maskImageView:UIImage?
    var filledColor:UIColor?
    var delegate : YHStarViewDelegate?
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        tap = UITapGestureRecognizer(target: self,action: #selector(tapView))
        addGestureRecognizer(tap!)
   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func maskImage(maskImage:UIImage){
    
        maskImageView = maskImage
        if((maskLayer) == nil){
            self.maskLayer = CALayer()
            self.maskLayer?.frame = CGRectMake(0,0, maskImage.size.width, maskImage.size.height)
            self.layer.mask = maskLayer
        }
        self.maskLayer?.contents = maskImageView!.CGImage
    
    }
    
    func borderImage(borderImage:UIImage){
    
        if((borderImageView) == nil){
        
            self.borderImageView = UIImageView(frame:CGRectMake(0,0, borderImage.size.width, borderImage.size.height))
            self.addSubview(borderImageView!)
        
        }
        self.borderImageView?.image = borderImage
        self.sendSubviewToBack(borderImageView!)
    
    }
 
    func fillColor(fillColor:UIColor){
      
        filledColor = fillColor
        if((fillView) == nil){
        
        self.fillView = UIView(frame:self.bounds)
        self.fillView?.layer.cornerRadius = self.bounds.size.width/2
        self.fillView?.transform = CGAffineTransformMakeScale(0, 0)
        self.addSubview(fillView!)
        }
        self.fillView?.backgroundColor = filledColor
    
    }
    func tapView(tapGestureRecognizer:UITapGestureRecognizer){
    
        self.userInteractionEnabled = false
        if(CGAffineTransformIsIdentity((fillView?.transform)!)){
        
            UIView.animateWithDuration(0.25, delay:0, options:UIViewAnimationOptions.CurveLinear, animations: {
                
                self.fillView?.transform = CGAffineTransformMakeScale(CGFloat(FLT_MIN), CGFloat(FLT_MIN))
                
                }, completion: { (Bool) in
                    
                    self.delegate?.sendStarValue(0)
                    self.userInteractionEnabled = true
                    
                })
        }else{
            UIView.animateWithDuration(0.35, delay:0, options:UIViewAnimationOptions.CurveEaseOut, animations: {
                
                self.fillView?.transform = CGAffineTransformMakeScale(1,1)
                
                }, completion: { (Bool) in
                    
                    self.delegate?.sendStarValue(1)
                    self.userInteractionEnabled = true
                    
            })
        }}


}