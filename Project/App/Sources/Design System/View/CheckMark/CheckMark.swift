//
//  CheckMark.swift
//  ProductName
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct CheckMark: View {
  private let size: Size
  private let style: Style
  private let checkImage: Image = ImageResource.check.image
  
  init(
    size: Size,
    style: Style
  ) {
    self.size = size
    self.style = style
  }
  
  var body: some View {
    Circle()
      .frame(width: size.circleSize, height: size.circleSize)
      .foregroundStyle(style.backgroundColor)
      .overlay {
        checkImage
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(style.foregroundColor)
          .frame(width: size.checkSize, height: size.checkSize)
      }
  }
}

extension CheckMark {
  enum Size {
    case medium
    case small
    
    var circleSize: CGFloat {
      switch self {
        case .medium:
          return 24
        case .small:
          return 20
      }
    }
    
    var checkSize: CGFloat {
      switch self {
        case .medium:
          return 14
        case .small:
          return 12
      }
    }
  }
  
  enum Style {
    case active
    case enabled
    case disabled
    
    var backgroundColor: Color {
      switch self {
        case .active:
          ColorResource.Text.Highlights.primary.color
        case .enabled:
          ColorResource.Neutral._400.color
        case .disabled:
          ColorResource.Neutral._500.color
      }
    }
    
    var foregroundColor: Color {
      switch self {
        case .active, .enabled:
          ColorResource.Text.main.color
        case .disabled:
          ColorResource.Neutral._400.color
      }
    }
  }
}

#Preview {
  VStack {
    HStack {
      CheckMark(size: .medium, style: .active)
      CheckMark(size: .medium, style: .enabled)
      CheckMark(size: .medium, style: .disabled)
    }
    HStack {
      CheckMark(size: .small, style: .active)
      CheckMark(size: .small, style: .enabled)
      CheckMark(size: .small, style: .disabled)
    }
  }
}
