//
//  GuideViewController.swift
//  Microduino
//
//  Created by harvey on 16/3/22.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import AVFoundation

class GuideViewController: GuideBaseViewController {

    @IBOutlet var backImageView:UIImageView?
    var player:AVPlayer!
    var playerItem:AVPlayerItem!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initPlayVideo()
        doAnimation()
      
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.player.play()
     
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        self.player.pause()
      
    }
    
    func doAnimation()
    {
        var images:[UIImage]=[]
        var image:UIImage?
        var imageName:String?
   
        for index in 0..<67{
            imageName = "logo-" + String(format: "%03d", index)
            image = UIImage(named: imageName!)
            print(index)
            images.insert(image!, atIndex: index)
        }
        backImageView?.animationImages = images
        backImageView?.animationRepeatCount = 1
        backImageView?.animationDuration = 5
        backImageView?.startAnimating()
        
        UIView.animateWithDuration(0.7, delay:5, options: .CurveEaseOut, animations: {
            self.backView!.alpha = 1.0
            self.player?.play()
            }, completion: {
                finished in
                print("Animation End")
        })
       
    }

    func initPlayVideo ()
    {
        let path = NSBundle.mainBundle().pathForResource("mCookie", ofType: "mp4")
        let url = NSURL.fileURLWithPath(path!)
        
        playerItem = AVPlayerItem(URL: url)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        print(backView.bounds)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity =  AVLayerVideoGravityResizeAspectFill
        
        self.player!.actionAtItemEnd = AVPlayerActionAtItemEnd.None
        
        backView!.layer.insertSublayer(playerLayer, atIndex: 0)
        backView!.alpha = 0.0
        
        NSNotificationCenter.defaultCenter().addObserver ( self,
                                                           selector: #selector(GuideViewController.didFinishVideo(_:)) ,
                                                           name: AVPlayerItemDidPlayToEndTimeNotification ,
                                                           object: playerItem)
    }
    
    func didFinishVideo(sender: NSNotification )
    {
        let item = sender.object as! AVPlayerItem
        
        item.seekToTime(kCMTimeZero)
        
        self.player.play()
    }
    
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init ()
    {
        var nibNameOrNil = String?("GuidePage")
        
        //考虑到xib文件可能不存在或被删，故加入判断
        if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "nib") == nil {
            nibNameOrNil = nil
        }
        
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    
    
}
