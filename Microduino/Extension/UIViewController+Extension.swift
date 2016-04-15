//
//  UIViewController+Additions.swift
//  YHAPP
//
//  Created by HeHongwe on 15/12/25.
//  Copyright © 2015年 harvey. All rights reserved.
//
import Foundation
import UIKit

extension UIViewController {
    
    func keyboardWillChangeFrameNotification(notification: NSNotification, scrollBottomConstant: NSLayoutConstraint) {
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let keyboardBeginFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardEndFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        let isBeginOrEnd = keyboardBeginFrame.origin.y == screenHeight || keyboardEndFrame.origin.y == screenHeight
        let heightOffset = keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y - (isBeginOrEnd ? bottomLayoutGuide.length : 0)
        
        UIView.animateWithDuration(duration.doubleValue,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: UInt(curve.integerValue << 16)),
            animations: { () in
                scrollBottomConstant.constant = scrollBottomConstant.constant + heightOffset
                self.view.layoutIfNeeded()
            },
            completion: nil
        )
    }

    func showProgress () {
        let progressView : UIImageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        progressView.tag = 500
        progressView.center = self.view.center
        self.view.addSubview(progressView)
        
        var imgArray : Array<UIImage> = Array()
        // 添加图片
        for i in 0..<8 {
            let image : UIImage = UIImage(named: "loading_\(i+1)")!
            imgArray.append(image)
        }
        progressView.animationImages = imgArray
        progressView.animationDuration = 0.5
        progressView.animationRepeatCount = 999
        progressView.startAnimating()
    }
    
    func hiddenProgress() {
        for view in self.view.subviews {
            if view.tag == 500 {
                let imgView : UIImageView = view as! UIImageView
                imgView.stopAnimating()
                imgView.performSelector(Selector("setAnimationImages:") , withObject: nil)
            }
        }
    }
    
    func showNetWorkErrorView () {
        let errorView : UIButton = UIButton(frame: CGRectMake(0, 0, 150, 145))
        errorView.center = self.view.center
        errorView.setImage(UIImage(named: "not_network_icon_unpre"), forState: .Normal)
        errorView.setImage(UIImage(named: "not_network_icon_pre"), forState: .Highlighted)
        errorView.addTarget(self, action: #selector(errorViewDidClick(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(errorView)
        // 让他处在view的最上层
        self.view.bringSubviewToFront(errorView)
    }
    
    func errorViewDidClick(errorView : UIButton) {
        errorView.removeFromSuperview()
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFY_ERRORBTNCLICK, object: nil)
    }
    

    
}