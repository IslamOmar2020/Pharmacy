//
//  MainVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/4/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import AVKit
class MainVC: UIViewController {

   var videoPlayer : AVPlayer?
    var videoPlayerlayer : AVPlayerLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVideo()
    }
    
    func setUpVideo(){
          // Get the path to the resource in the bundle
              let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
              
              guard bundlePath != nil else {
                  return
              }
              
              // Create a URL from it
              let url = URL(fileURLWithPath: bundlePath!)
              
              // Create the video player item
              let item = AVPlayerItem(url: url)
              
              // Create the player
              videoPlayer = AVPlayer(playerItem: item)
              
              // Create the layer
              videoPlayerlayer = AVPlayerLayer(player: videoPlayer!)
              
              // Adjust the size and frame
              videoPlayerlayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
              
              view.layer.insertSublayer(videoPlayerlayer!, at: 0)
              
              // Add it to the view and play it
              videoPlayer?.playImmediately(atRate: 0.3)
          }
    
}
