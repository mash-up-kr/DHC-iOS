//
//  DotView.swift
//  ProductName
//
//  Created by 최혜린 on 6/22/25.
//

import SwiftUI

struct DotView: View {
  private let color: Color
  private let size: CGFloat
  
  init(color: Color, size: CGFloat) {
    self.color = color
    self.size = size
  }
  
  var body: some View {
    Circle()
      .fill(color)
      .frame(width: size, height: size)
  }
}
