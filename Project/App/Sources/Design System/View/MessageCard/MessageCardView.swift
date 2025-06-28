//
//  MessageCardView.swift
//  Flifin
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

struct MessageCardView: View {
  private let title: String
  private let message: String
  
  init(title: String, message: String) {
    self.title = title
    self.message = message
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .textStyle(.body5)
        .foregroundStyle(ColorResource.Neutral._400.color)
      
      Text(message)
        .textStyle(.body3)
        .foregroundStyle(ColorResource.Text.Body.primary.color)
        .padding(.bottom, 12)
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 16)
    .padding(.top, 20)
    .background(ColorResource.Neutral._700.color)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .frame(maxWidth: .infinity)
  }
}
