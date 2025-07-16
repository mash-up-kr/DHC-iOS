//
//  FortuneCardView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import SDWebImageSwiftUI

struct FortuneCardView: View {
  private let backgroundImageURL: URL?
  
  init(backgroundImageURL: URL?) {
    self.backgroundImageURL = backgroundImageURL
  }

  var body: some View {
    WebImage(
      url: backgroundImageURL,
      content: { image in
        image.resizable()
      },
      placeholder: {
        ImageResource.fortuneCardPlaceholder.image
          .resizable()
          .frame(width: 144, height: 200)
      }
    )
    .frame(width: 144, height: 200)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}
