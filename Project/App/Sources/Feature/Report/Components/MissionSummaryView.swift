//
//  MissionSummaryView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/22/25.
//

import SwiftUI

struct MissionSummaryView: View {
  private let imageResource: ImageResource
  private let title: String
  private let description: String

  init(imageResource: ImageResource, title: String, description: String) {
    self.imageResource = imageResource
    self.title = title
    self.description = description
  }

  var body: some View {
    HStack(spacing: 12) {

      ZStack {
        Circle()
          .fill(ColorResource.Neutral._800.color)
          .frame(width: 54, height: 54)

        Image(imageResource)
          .resizable()
          .frame(width: 26, height: 26)
      }

      VStack(alignment: .leading, spacing: 0) {
        Text(title)
          .foregroundStyle(ColorResource.Text.Body.primary.color)
          .textStyle(.body3)

        Text(description)
          .foregroundStyle(ColorResource.Text.main.color)
          .textStyle(.h3)
      }
    }
    .padding(.vertical, 12)
    .padding(.horizontal, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(ColorResource.Neutral._700.color)
    )
  }
}

#Preview {
  MissionSummaryView(
    imageResource: .moneyWithWings,
    title: "지금까지 총",
    description: "130,000원 아꼈어요!"
  )
}
