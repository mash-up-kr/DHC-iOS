//
//  Check.swift
//  ProductName
//
//  Created by hyerin on 6/12/25.
//

import SwiftUI

struct Check: View {
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
    checkImage
      .resizable()
      .renderingMode(.template)
      .foregroundStyle(style.foregroundColor)
      .frame(width: size.checkSize, height: size.checkSize)
      .padding(size.inset)
      .background {
        Circle()
          .foregroundStyle(style.backgroundColor)
      }
  }
}

extension Check {
  enum Size {
    case medium
    case small
    
    var inset: CGFloat {
      switch self {
        case .medium:
          return 6
        case .small:
          return 4
      }
    }
    
    var checkSize: CGFloat {
      switch self {
        case .medium:
          return 16
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
      Check(size: .medium, style: .active)
      Check(size: .medium, style: .enabled)
      Check(size: .medium, style: .disabled)
    }
    HStack {
      Check(size: .small, style: .active)
      Check(size: .small, style: .enabled)
      Check(size: .small, style: .disabled)
    }
  }
}
