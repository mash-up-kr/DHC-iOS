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
  }
  
  var body: some View {
    VideoPlayer(player: player)
      .onAppear { player.play() }
      .onDisappear{ player.pause() }
  }
}
