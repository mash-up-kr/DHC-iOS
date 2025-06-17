//
//  BirthdayInfoView.swift
//  ProductName
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

struct BirthdayInfoView: View {

  private let date: String
  private let time: String

  init(date: String, time: String) {
    self.date = date
    self.time = time
  }

  var body: some View {
    HStack(spacing: 12) {
      Text(date)

      Divider()
        .frame(width: 1, height: 12)
        .background(ColorResource.Background.glassEffect.color)

      Text(time)
    }
    .textStyle(.body6)
    .foregroundStyle(ColorResource.Text.Body.primary.color)
    .padding(.horizontal, 12)
    .padding(.vertical, 4)
    .background(
      RoundedRectangle(cornerRadius: .infinity)
        .fill(ColorResource.Background.glassEffect.color)
    )
  }
}
