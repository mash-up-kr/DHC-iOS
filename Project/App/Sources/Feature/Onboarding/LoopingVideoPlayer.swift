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
  
  var body: some View {
    VideoPlayer(player: player)
      .onAppear { player.play() }
      .onDisappear{ player.pause() }
  }
  
  init(videoURL: URL) {
    let asset = AVURLAsset(url: videoURL)
    let item = AVPlayerItem(asset: asset)
    
    player = AVQueuePlayer(playerItem: item)
    playerLooper = AVPlayerLooper(player: player, templateItem: item)
  }
}
