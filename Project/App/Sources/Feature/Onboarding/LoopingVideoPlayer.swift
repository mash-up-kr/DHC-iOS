//
//  LoopingVideoPlayer.swift
//  Flifin
//
//  Created by hyerin on 7/1/25.
//

import AVKit
import SwiftUI

struct LoopingVideoPlayer: View {
  private let player: AVQueuePlayer
  private let playerLooper: AVPlayerLooper
  
  init(
    videoURL: URL,
    needSoundMute: Bool
  ) {
    let asset = AVURLAsset(url: videoURL)
    let item = AVPlayerItem(asset: asset)
    
    self.player = AVQueuePlayer(playerItem: item)
    self.player.isMuted = needSoundMute
    self.playerLooper = AVPlayerLooper(player: player, templateItem: item)
    try? AVAudioSession.sharedInstance().setCategory(
      AVAudioSession.Category.playback,
      mode: .default,
      options: .mixWithOthers
    )
  }
  
  var body: some View {
    VideoPlayer(player: player)
      .onAppear { 
        player.play() 
      }
      .onDisappear{ 
        player.pause() 
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
        if player.timeControlStatus != .playing {
          player.play()
        }
      }
  }
}
