//
//  Badge.swift
//  Flifin
//
//  Created by 김유빈 on 6/24/25.
//

import SwiftUI

struct Badge: View {
  let badgeTitle: String
  let textStyle: Typography.TypographyStyle
  let textColor: Color
  let backgroundColor: Color

  var body: some View {
    Text(badgeTitle)
      .textStyle(textStyle)
      .foregroundStyle(textColor)
      .padding(.horizontal, 12)
      .padding(.vertical, 4.5)
      .background {
        RoundedRectangle(cornerRadius: .infinity)
          .foregroundStyle(backgroundColor)
      }
      .fixedSize(horizontal: true, vertical: true)
  }
}

#Preview {
  Badge(
    badgeTitle: "식음료",
    textStyle: Typography.Head.h8,
    textColor: ColorResource.Text.Highlights.secondary.color,
    backgroundColor: ColorResource.Background.glassEffect.color
  )
}
