//
//  VideoViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 23.07.22.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    // MARK: - Variables
    
    private let videoUrlStr = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
    
    var player: AVPlayer? = nil
    
    private lazy var playerViewController: AVPlayerViewController = {
        return AVPlayerViewController()
    }()
    
    // MARK: - UI Components
    
    private lazy var videoPreviewView: UIView = {
        let view = UIView()
        
        self.view.addSubview(view)
        
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var playBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Play", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.videoPreviewView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(self.videoPreviewView.snp.height).multipliedBy(2)
        }
                
        self.videoPreviewView.addSubview(self.playerViewController.view)
        
        self.playerViewController.view.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        self.playBtn.snp.makeConstraints { make in
            make.top.equalTo(self.videoPreviewView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        let videoURL = URL(string: videoUrlStr)!
        self.player = AVPlayer(url: videoURL)
        
        self.playerViewController.player = self.player
        
        let title: String = L10n.titleTwitterPage

        print(title)
    }
    
    @objc func onPlay() {
        self.playerViewController.player?.play()
    }
}
