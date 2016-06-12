//
//  UIImageView+XM.swift
//  Microduino
//
//  Created by harvey on 16/3/14.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import YYWebImage

extension UIImageView {
    
    
    // 普通效果
    func xm_setImageWithURL(url : NSURL!, placeholderImage: UIImage!) {
        return self.yy_setImageWithURL(url, placeholder: placeholderImage)
    }
    
    func xm_setBlurImageWithURL(URL : NSURL!, placeholderImage: UIImage!) {
        return self.yy_setImageWithURL(URL, placeholder: placeholderImage, options: [YYWebImageOptions.ProgressiveBlur,YYWebImageOptions.SetImageWithFadeAnimation], completion: { (image, url, type, stage, error) -> Void in
            if type == YYWebImageFromType.DiskCache {
                self.image = image
            }
        })
    }

    /**
     Loads an image from a URL. If cached, the cached image is returned. Otherwise, a place holder is used until the image from web is returned by the closure.
     
     - Parameter url: The image URL.
     - Parameter placeholder: The placeholder image.
     - Parameter fadeIn: Weather the mage should fade in.
     - Parameter closure: Returns the image from the web the first time is fetched.
     
     - Returns A new image
     */
    func imageFromURL(url: String, placeholder: UIImage, fadeIn: Bool = true, shouldCacheImage: Bool = true, closure: ((image: UIImage?) -> ())? = nil)
    {
        self.image = UIImage.imageFromURL(url, placeholder: placeholder, shouldCacheImage: shouldCacheImage) {
            (image: UIImage?) in
            if image == nil {
                return
            }
            if fadeIn {
                let crossFade = CABasicAnimation(keyPath: "contents")
                crossFade.duration = 0.5
                crossFade.fromValue = self.image?.CIImage
                crossFade.toValue = image!.CGImage
                self.layer.addAnimation(crossFade, forKey: "")
            }
            if let foundClosure = closure {
                foundClosure(image: image)
            }
            self.image = image
        }
    }
    
    
    func YH_setIndicatorImageWithUrl(url:NSURL,placeHolderImage:UIImage){
    
        var indicatorPlaceholder:UIActivityIndicatorView?
      
        self.kf_setImageWithURL(url, placeholderImage: placeHolderImage, optionsInfo:[.ForceRefresh], progressBlock: { (receivedSize, totalSize) in
            if((indicatorPlaceholder) == nil){
            dispatch_async(dispatch_get_main_queue(), {
                indicatorPlaceholder = UIActivityIndicatorView()
                indicatorPlaceholder!.activityIndicatorViewStyle = .White
                self.addSubview(indicatorPlaceholder!)
                indicatorPlaceholder!.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
                indicatorPlaceholder!.hidesWhenStopped = true
                indicatorPlaceholder!.startAnimating()
            })}
            }) { (image, error, cacheType, imageURL) in
         
                if(cacheType == .None){
                self.alpha = 0.1
                UIView.animateWithDuration(0.5, animations: {
                self.alpha = 1.0
                })
            }
                
                for view in self.subviews{
                
                    if indicatorPlaceholder!.isKindOfClass(UIActivityIndicatorView.classForCoder()){
                    
                        view.removeFromSuperview()
                    
                    }
                
                }
        }
    }
}