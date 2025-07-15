//
//  Gradient.swift
//  Flifin
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

extension LinearGradient {
  enum LinearType {
    case tooltip01
    case text01
    case text02
    case cardBorder
    case fortuneFill
    case fortuneBorderLow
    case fortuneBorderMid
    case fortuneBorderTop
    case fortuneGradientLow
    case fortuneGradientMid
    case fortuneGradientTop
    case buttonBorder01

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
      case .cardBorder:
        return [
          .init(color: ColorResource.D_7_E_1_EE.color.opacity(0.3), location: 0),
          .init(color: ColorResource._414_BAE.color.opacity(0.3), location: 0.89),
          .init(color: ColorResource.Neutral._500.color, location: 1.0),
        ]

      // MARK: Fortune Core
      case .fortuneFill:
        return [
          .init(color: ColorResource.Background.glassEffect.color, location: 0),
          .init(color: ColorResource.Text.Highlights.secondary.color, location: 1.0),
        ]

      case .fortuneBorderLow:
        return [
          .init(color: ColorResource.Neutral._400.color, location: 0),
          .init(color: ColorResource.Neutral._200.color, location: 1.0),
        ]
      case .fortuneBorderMid:
        return [
          .init(color: ColorResource.Violet._400.color, location: 0),
          .init(color: ColorResource.Neutral._200.color, location: 1.0),
        ]
      case .fortuneBorderTop:
        return [
          .init(color: ColorResource.Violet._400.color, location: 0),
          .init(color: ColorResource.Neutral._200.color, location: 1.0),
        ]

      case .fortuneGradientLow:
        return [
          .init(color: ColorResource.EEEBD_8.color, location: 0.17),
          .init(color: ColorResource._6_F_6_F_6_F.color, location: 1.0),
        ]
      case .fortuneGradientMid:
        return [
          .init(color: ColorResource.Neutral._30.color, location: 0.17),
          .init(color: ColorResource.Violet._500.color, location: 1.0),
        ]
      case .fortuneGradientTop:
        return [
          .init(color: ColorResource.E_9_FBFF.color, location: 0.17),
          .init(color: ColorResource._5194_FF.color, location: 1.0),
        ]
        
      case .buttonBorder01:
        return [
          .init(color: ColorResource.Violet._400.color, location: 0),
          .init(color: ColorResource.Violet._400.color, location: 0.83),
          .init(color: ColorResource.Violet._300.color, location: 1.0)
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
