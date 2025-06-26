//
//  Gradient.swift
//  ProductName
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

extension LinearGradient {
  enum LinearType {
    case tooltip01
    case text01
    case text02
    
    var stops: [Gradient.Stop] {
      switch self {
        case .tooltip01:
          return [
            .init(color: ColorResource.Neutral._30.color, location: 0.43),
            .init(color: ColorResource.Text.Highlights.secondary.color, location: 1.0)
          ]
        case .text01:
          return [
            .init(color: ColorResource.Text.Highlights.secondary.color, location: 0.16),
            .init(color: ColorResource.Text.main.color, location: 0.83)
          ]
        case .text02:
          return [
            .init(color: ColorResource.Text.Highlights.secondary.color, location: 0.16),
            .init(color: ColorResource.Text.main.color, location: 1.0)
          ]
      }
    }
  }
  
  init(
    _ type: LinearType,
    startPoint: UnitPoint = .top,
    endPoint: UnitPoint = .bottom
  ) {
    self = .init(
      stops: type.stops,
      startPoint: startPoint,
      endPoint: endPoint
    )
  }
}

#Preview {
  Rectangle()
    .fill(LinearGradient(.tooltip01))
}
