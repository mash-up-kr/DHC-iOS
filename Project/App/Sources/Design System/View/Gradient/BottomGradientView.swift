//
//  BottomGradient.swift
//  Flifin
//
//  Created by hyerin on 6/25/25.
//

import SwiftUI

struct BottomGradientView: View {
  var body: some View {
    LinearGradient(
      colors: [
        ColorResource.Neutral._900.color.opacity(0),
        ColorResource.Neutral._900.color
      ],
      startPoint: .top,
      endPoint: .bottom
    )
    .frame(height: 40)
  }
}
