//
//  IntroInfoView.swift
//  Flifin
//
//  Created by hyerin on 6/17/25.
//

import SwiftUI

struct IntroInfoView: View {
  private let index: Int
  private let info: String
  
  init(
    index: Int,
    info: String
  ) {
    self.index = index
    self.info = info
  }
  
  var body: some View {
    HStack(spacing: 12) {
      indexView(index)
      
      Text(info)
        .textStyle(.h4)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
    }
    .padding(20)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(ColorResource.Neutral._700.color)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
  
  func indexView(_ index: Int) -> some View {
    Circle()
      .foregroundStyle(ColorResource.Neutral._300.color)
      .frame(width: 24, height: 24)
      .overlay {
        Text("\(index)")
          .textStyle(.h5)
          .foregroundStyle(ColorResource.Background.main.color)
      }
  }
}
