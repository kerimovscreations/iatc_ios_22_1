//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import YPImagePicker
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Variables
    
//    var player: AVAudioPlayer?
    var player: AVPlayer?
    
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                self.playBtn.setTitle("Pause audio", for: .normal)
            } else {
                self.playBtn.setTitle("Play audio", for: .normal)
            }
        }
    }
    
    // MARK: - UI Components
    
    private lazy var image: UIImageView = {
        let iv = UIImageView()
        
        self.view.addSubview(iv)
        
        iv.contentMode = .scaleAspectFill
        
        iv.clipsToBounds = true
        
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    private lazy var pickBtn: UIButton = {
        let btn = UIButton()
        
        self.view.addSubview(btn)
        
        btn.setTitle("Pick image", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        
        btn.addTarget(self, action: #selector(onPick), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var playBtn: UIButton = {
        let btn = UIButton()
        
        self.view.addSubview(btn)
        
        btn.setTitle("Play audio", for: .normal)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        
        btn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        
        return btn
    }()
    
    // MARK: - Parent delegates
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.backgroundColor = .white
        
        self.image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(self.image.snp.height).multipliedBy(1)
        }
        
        self.image.image = Asset.Media.apple.image
                
        self.pickBtn.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        self.playBtn.snp.makeConstraints { make in
            make.top.equalTo(self.pickBtn.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func onPick() {
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.mediaType = .photo
        config.library.maxNumberOfItems = 2
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { items, cancelled in
            if cancelled {
                print("Picker is cancelled")
                picker.dismiss(animated: true)
                return
            }
            
            items.forEach { item in
                switch item {
                case .photo(let photoItem):
                    print(photoItem.fromCamera) // Image source (camera or library)
                    print(photoItem.image) // Final image selected by the user
                    print(photoItem.originalImage) // original image selected by the user, unfiltered
                    print(photoItem.modifiedImage) // Transformed image, can be nil
                    print(photoItem.exifMeta) // Print exif meta data of original image.
                    
                    self.image.image = photoItem.image
                case .video(_):
                    break
                }
            }
            
            //            if let photo = items.singlePhoto {
            //                print(photo.fromCamera) // Image source (camera or library)
            //                print(photo.image) // Final image selected by the user
            //                print(photo.originalImage) // original image selected by the user, unfiltered
            //                print(photo.modifiedImage) // Transformed image, can be nil
            //                print(photo.exifMeta) // Print exif meta data of original image.
            //
            //                self.image.image = photo.image
            //            }
            
            picker.dismiss(animated: true)
        }
        
        self.present(picker, animated: true)
    }
    
    @objc func onPlay() {
        if isPlaying {
            pausePlay()
        } else {
            startPlay()
        }
    }
    
    private func pausePlay() {
        player?.pause()
        isPlaying = false
    }
    
    private func startPlay() {
        if let safePlayer = player {
            safePlayer.play()
            isPlaying = true
            return
        }
        
//        guard let path = Bundle.main.path(forResource: "test", ofType:"mp3") else {
//            return }
        
//        let url = URL(fileURLWithPath: path)
        let url = URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        do {
//            player = try AVAudioPlayer(url: url)
//            player?.delegate = self

            self.player = AVPlayer(playerItem: item)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)

            player?.volume = 1.0
            player?.play()
            isPlaying = true
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        print(#function)
        self.player = nil
        self.isPlaying = false
    }
}

extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = nil
        isPlaying = false
    }
}

