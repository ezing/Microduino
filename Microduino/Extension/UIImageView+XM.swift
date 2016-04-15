//
//  UIImageView+XM.swift
//  BeautifulApp
//
//  Created by 梁亦明 on 15/12/3.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import UIKit

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
    
    func configureImageViwWithImageURL(url:NSURL!,animated:Bool){
    
        let progressIndicatorView = CircularLoaderView(frame:CGRectZero)
        self.addSubview(progressIndicatorView)
        
        if  animated {
            progressIndicatorView.frame = self.bounds
            progressIndicatorView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
            progressIndicatorView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            self.kf_setImageWithURL(NSURL(string: "your_image_url")!,
                                         placeholderImage: nil,
                                         optionsInfo: nil,
                                         progressBlock: { (receivedSize, totalSize) -> () in
                                            print("Download Progress: \(receivedSize)/\(totalSize)")
                                        progressIndicatorView.progress = CGFloat(receivedSize/totalSize)
                },
                                         completionHandler: { (image, error, cacheType, imageURL) -> () in
                                         progressIndicatorView.frame = CGRectZero
                                         self.kf_setImageWithURL(url)
                                            
                                            print("Downloaded and set!")
                }
            )
        }
    
    
    }

}