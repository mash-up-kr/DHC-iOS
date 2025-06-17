//
//  FortuneInfoCardView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

import SDWebImageSwiftUI

struct FortuneInfoCardView: View {

  private let imageURL: URL
  private let fortune: String

  init(imageURL: URL, fortune: String) {
    self.imageURL = imageURL
    self.fortune = fortune
  }

  var body: some View {
    VStack(spacing: 4) {
      WebImage(url: imageURL) { image in
        image
      } placeholder: {
        Rectangle()
      }
      .resizable()
      .frame(width: 36, height: 36)

      VStack(spacing: 0) {
        Text("내 사주는")
          .textStyle(.body6)
          .foregroundStyle(ColorResource.Neutral._200.color)
        Text(fortune)
          .textStyle(.h2)
          .foregroundStyle(LinearGradient(.text02))
      }
    }
    .padding(12)
    .frame(width: 180, height: 120)
    .background {
      RoundedRectangle(cornerRadius: 12)
        .fill(ColorResource.Neutral._900.color)
        .stroke(LinearGradient(.cardBorder))
        .opacity(0.6)
    }
  }
}
