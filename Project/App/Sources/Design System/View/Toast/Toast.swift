//
//  Toast.swift
//  Flifin
//
//  Created by 김유빈 on 7/1/25.
//

import SwiftUI

struct Toast: View {
  private let message: String
  private let backgroundColor: Color
  private let cornerRadius: CGFloat
  private let textStyle: Typography.TypographyStyle
  private let textColor: Color

  init(
    message: String,
    backgroundColor: Color,
    cornerRadius: CGFloat,
    textStyle: Typography.TypographyStyle,
    textColor: Color
  ) {
    self.message = message
    self.backgroundColor = backgroundColor
    self.cornerRadius = cornerRadius
    self.textStyle = textStyle
    self.textColor = textColor
  }

  var body: some View {
    HStack(spacing: 8) {
      CheckMark(size: .small, style: .active)
        .padding(.vertical, 5)

      Text(message)
        .textStyle(textStyle)
        .padding(.horizontal, 4)
        .padding(.vertical, 2)
        .foregroundStyle(textColor)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 12)
    .background {
      RoundedRectangle(cornerRadius: cornerRadius)
        .foregroundStyle(backgroundColor)
    }
  }
}

#Preview {
  Toast(
    message: "차근차근 잘하고 있어요!",
    backgroundColor: ColorResource.Neutral._500.color,
    cornerRadius: 12,
    textStyle: Typography.Body.body4,
    textColor: ColorResource.Text.main.color
  )
}
