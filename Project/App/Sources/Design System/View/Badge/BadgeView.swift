//
//  BadgeView.swift
//  Flifin
//
//  Created by 최혜린 on 6/18/25.
//

import SwiftUI

struct BadgeView: View {
  private let text: String
  private let textColor: Color
  private let font: Typography.TypographyStyle
  private let backgroundColor: Color
  
  init(
    text: String,
    textColor: Color,
    font: Typography.TypographyStyle,
    backgroundColor: Color = ColorResource.Background.glassEffect.color
  ) {
    self.text = text
    self.textColor = textColor
    self.font = font
    self.backgroundColor = backgroundColor
  }
  
  var body: some View {
    Text(text)
      .textStyle(font)
      .foregroundStyle(textColor)
      .padding(.vertical, 4)
      .padding(.horizontal, 12)
      .background(backgroundColor)
      .clipShape(RoundedRectangle(cornerRadius: .infinity))
  }
}

#Preview {
  VStack {
    BadgeView(
      text: "2025년 5월 20일",
      textColor: ColorResource.Text.Body.primary.color,
      font: Typography.Body.body6
    )
    
    BadgeView(
      text: "Easy",
      textColor: ColorResource.Text.Highlights.primary.color,
      font: Typography.Body.body6,
      backgroundColor: ColorResource.Background.badgePrimary.color
    )
  }
  .background(ColorResource.Background.main.color)
}
