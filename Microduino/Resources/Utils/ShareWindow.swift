//
//  ShareView.swift
//  ShareView
//
//  Created by Delta-AEC-APP on 16/4/19.
//  Copyright © 2016年 AEC. All rights reserved.
//



import UIKit
protocol ShareWindowDelegate : NSObjectProtocol {
    func touchItemAtIndex(index : NSInteger)
    
    
}
//继承自window，弹出为顶层，不让别的层相应事件
class ShareWindow: UIWindow {
//    通过代理传递事件
    weak var delegate : ShareWindowDelegate?
    
    let screenW = UIScreen.mainScreen().bounds.width
    let screenH = UIScreen.mainScreen().bounds.height
    
    let buttonH = (UIScreen.mainScreen().bounds.width - 50.0) / 5
    let titleH : CGFloat = 20.0
    let Item_Counts_Per_Row : CGFloat = 4.0
    let Item_Start_Original_Y :CGFloat =  10.0
    
    var  shareView = UIView()
//    单利
    static let shareInstance = ShareWindow()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//       根据该数组设置ui
        setUpUI(["scada_imageWeChat", "scada_imageEmail", "scada_imageMes"], titleArray: ["微信", "邮件", "信息"])

        self.addSubview(shareView)
    }
    
    func showShareView(){
        
        self.backgroundColor = UIColor.clearColor()
        UIView.animateWithDuration(0.2) { 
            
            self.shareView.frame.origin.y = self.screenH - 190
//
        }

        
        self.hidden = false
        

    }
//    给动画
    func hideShareView()  {
       
        UIView.animateWithDuration(0.3, animations: { 
          
            self.shareView.frame.origin.y = self.screenH
            }) { (isFinished) in
                 self.hidden = true
        }
       

        
    }
 
        
        
        
    func setUpUI(imageArray : NSArray,titleArray: NSArray)  {
        
        
        shareView = UIView(frame: CGRectMake(0, screenH, screenW, buttonH  + titleH + 2 * 10 + 80.0) )
        
        
         let viewItemBack  = UIView(frame: CGRectMake(10.0, 10.0, screenW - 20.0, buttonH + titleH + 2 * 10) )


            viewItemBack.userInteractionEnabled = true
            viewItemBack.layer.cornerRadius = 8.0
            viewItemBack.layer.masksToBounds = true
            viewItemBack.backgroundColor = UIColor.darkGrayColor()
        
            self.shareView.addSubview(viewItemBack)
            let buttonCancel = UIButton()
        

            buttonCancel.backgroundColor = UIColor.darkGrayColor()
            buttonCancel.layer.cornerRadius = 25.0
            buttonCancel.layer.masksToBounds = true
            buttonCancel.frame = CGRectMake(10.0, self.shareView.frame.size.height - 55.0, screenW - 20.0, 50.0)
            buttonCancel.setTitle("取消", forState: .Normal)
            buttonCancel.addTarget(self, action:#selector(ShareWindow.touchCancelButton(_:)), forControlEvents: .TouchUpInside)
        
            shareView.addSubview(buttonCancel)
            // x方向距离
            let  itemDistanceX = (viewItemBack.frame.size.width - buttonH * Item_Counts_Per_Row) / (Item_Counts_Per_Row * 2 * 1.0);
            
            var  x : CGFloat = 0.0
            var y : CGFloat = 0.0
            var row = 0
            var col = 0
            
            var buttonItem : UIButton?
            var labelItem : UILabel?
        
            for index in 0 ..< titleArray.count
            {
                if index % Int(Item_Counts_Per_Row) == 0
                {
                    col = 0
                }
                
                // 61 69 77
                // 计算x坐标
                x = (CGFloat(col) * 2 + 1) * itemDistanceX + CGFloat(col) * buttonH
                col += 1
                
                // 计算y坐标
                row = index / Int(Item_Counts_Per_Row)
                y = row == 0 ? 10.0 : CGFloat(row) * (buttonH + titleH + Item_Start_Original_Y)
               
                // 显示头像的view
                buttonItem = UIButton(frame:  CGRectMake(x, y, buttonH, buttonH))
                buttonItem!.backgroundColor = UIColor.clearColor()
                buttonItem!.tag = index
               
                buttonItem?.setImage(UIImage(named:imageArray[index] as! String), forState: .Normal)
                buttonItem?.addTarget(self, action: #selector(ShareWindow.touchItemButton(_:)), forControlEvents: .TouchUpInside)
                
                // 显示名字
                
                labelItem = UILabel(frame: CGRectMake(buttonItem!.frame.origin.x - itemDistanceX + 2, buttonItem!.frame.origin.y + buttonH, buttonH + itemDistanceX * 2 - 4, titleH))

                labelItem?.font = UIFont.systemFontOfSize(12)
//
                
               labelItem?.textColor = UIColor.whiteColor()
                labelItem?.textAlignment = .Center

                
                labelItem!.text = titleArray[index] as? String;
                shareView.addSubview(buttonItem!)
                shareView.addSubview(labelItem!)
            }
        

    }
    
    
    
    
      
        
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        if self.frame.origin.y == screenH - 120 {
//            return nil
//        }
//        
//        return self
//        
//        
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hideShareView()
    }
    
    // MARK - Touch Method
   @objc func touchCancelButton(sender : UIButton) {
        
        hideShareView()
    }

    
    
    @objc func touchItemButton(sender : UIButton) {
        
        self.delegate?.touchItemAtIndex(sender.tag)
    }


}
