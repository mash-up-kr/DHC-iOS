//
//  FortuneCardBackView.swift
//  Flifin
//
//  Created by 최혜린 on 7/1/25.
//

import SwiftUI

struct FortuneCardBackView: View {
  private let backgroundImageURL: URL?
  
  init(backgroundImageURL: URL?) {
    self.backgroundImageURL = backgroundImageURL
  }
  
  var body: some View {
    FortuneCardView(backgroundImageURL: backgroundImageURL)
    .overlay {
      RoundedRectangle(cornerRadius: 12)
        .strokeBorder(LinearGradient(.cardBorder))
    }
  }
}
