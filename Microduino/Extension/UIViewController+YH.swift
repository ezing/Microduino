//
//  UIViewController+Additions.swift
//  YHAPP
//
//  Created by HeHongwe on 15/12/25.
//  Copyright © 2015年 harvey. All rights reserved.
//
import Foundation
import UIKit
import KRProgressHUD
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
    
        KRProgressHUD.show()

    }
    
    func hiddenProgress() {
    
        KRProgressHUD.dismiss()
        
    }
    
    func showNetWorkErrorView () {
        let errorView : UIButton = UIButton(frame: CGRectMake(0, 0, 150, 145))
        errorView.center = self.view.center
        errorView.setImage(UIImage(named: "not_network_icon_unpre"), forState: .Normal)
        errorView.setImage(UIImage(named: "not_network_icon_pre"), forState: .Highlighted)
        errorView.addTarget(self, action: #selector(errorViewDidClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(errorView)
        self.view.bringSubviewToFront(errorView)
    }
    
    func errorViewDidClick(errorView : UIButton) {
        errorView.removeFromSuperview()
        NSNotificationCenter.defaultCenter().postNotificationName(NOTIFY_ERRORBTNCLICK, object: nil)
    }
    

    
}