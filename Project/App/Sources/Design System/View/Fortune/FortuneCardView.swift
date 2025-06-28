//
//  FortuneCardView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

import SDWebImageSwiftUI

struct FortuneCardView: View {
  private let backgroundImageURL: URL
  private let title: String
  private let fortune: String
  
  init(
    backgroundImageURL: URL,
    title: String,
    fortune: String
  ) {
    self.backgroundImageURL = backgroundImageURL
    self.title = title
    self.fortune = fortune
  }

  var body: some View {
    WebImage(
      url: backgroundImageURL,
      content: { image in
        image.resizable()
      },
      placeholder: {
        Rectangle()
      }
    )
    .frame(width: 144, height: 200, alignment: .center)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .overlay {
      RoundedRectangle(cornerRadius: 12)
        .strokeBorder(LinearGradient(.cardBorder))
    }
    .overlay(alignment: .top) {
      VStack(spacing: 0) {
        Text(title)
          .textStyle(.h8)
          .foregroundStyle(LinearGradient(.text02))
        
        Text(fortune)
          .textStyle(.h6)
          .foregroundStyle(ColorResource.Text.Body.primary.color)
      }
      .padding(.top, 20)
    }
  }
}

#Preview {
  FortuneCardView(
    backgroundImageURL: URL(string: "https://img.freepik.com/free-vector/dark-gradient-background-with-copy-space_53876-99548.jpg")!,
    title: "최고의 날",
    fortune: "네잎클로버"
  )
}
