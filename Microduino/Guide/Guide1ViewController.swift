//
//  Guide1ViewController.swift
//  Microduino
//
//  Created by harvey on 16/4/6.
//  Copyright © 2016年 harvey. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class Guide1ViewController: UIViewController {

    var mediaPlayer:AVPlayerViewController?
    var audioSession:AVAudioSession?
    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        audioSession = AVAudioSession.sharedInstance()
//        try! audioSession?.setCategory(AVAudioSessionCategoryAmbient)
//      
//        let urlStr = NSBundle.mainBundle().pathForResource("mCookie", ofType:"mp4")
//       
//        mediaPlayer = AVPlayerViewController()
//        
//      
        playAVPlayerViewController()
        
    }

    // AVPlayerViewController播放音频
    func playAVPlayerViewController(){
        // 实例化AVPlayerViewController
        let AVVC:AVPlayerViewController = AVPlayerViewController()
        // 实例化AVPlayer
        let avPlayer:AVPlayer = AVPlayer(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mCookie", ofType: "mp4")!))
        // 添加AVPlayerViewController里的AVPlayer
        AVVC.player = avPlayer
        // Controller的跳转
        self.presentViewController(AVVC, animated: true) { () -> Void in
            // 调用AVPlayerViewController里的AVPlayer播放音频
            AVVC.player?.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
  
}
