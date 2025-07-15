//
//  RadialGradientBackground.swift
//  Flifin
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

extension RadialGradient {
  enum RadialType {
    case backgroundGradient01
    case backgroundGradient02
    case buttonSurface01
    
    var stops: [Gradient.Stop] {
      switch self {
      case .backgroundGradient01:
        return [
          .init(color: ColorResource.Violet._400.color, location: 0.23),
          .init(color: ColorResource.Violet._400.color.opacity(0.3), location: 0.51),
          .init(color: ColorResource.Violet._400.color.opacity(0.1), location: 0.75),
          .init(color: ColorResource.Violet._400.color.opacity(0.05), location: 0.88),
          .init(color: ColorResource.Violet._400.color.opacity(0), location: 1.0),
        ]
      case .backgroundGradient02:
        return [
          .init(color: ColorResource.Violet._400.color.opacity(0.5), location: 0),
          .init(color: ColorResource.Violet._400.color.opacity(0.34), location: 0.15),
          .init(color: ColorResource.Violet._400.color.opacity(0.08), location: 0.4),
          .init(color: ColorResource.Violet._400.color.opacity(0), location: 0.67)
        ]
      case .buttonSurface01:
        return [
          .init(color: ColorResource.Violet._300.color, location: 0.3),
          .init(color: ColorResource.Violet._300.color.opacity(0), location: 1.0)
        ]
      }
    }
    
    var center: UnitPoint {
      switch self {
      case .backgroundGradient01:
        return .init(x: UnitPoint.center.x, y: UnitPoint.center.y + 0.09)
      case .backgroundGradient02:
        return .init(x: UnitPoint.center.x + 0.22, y: UnitPoint.top.y)
      case .buttonSurface01:
        return .init(x: UnitPoint.center.x, y: UnitPoint.bottom.y + 0.2)
      }
    }
    
    var opacity: CGFloat {
      switch self {
      case .buttonSurface01:
        return 1.0
      case .backgroundGradient01, .backgroundGradient02:
        return 0.6
      }
    }
  }
}

struct RadialGradientBackground: ViewModifier {
  let stops: [Gradient.Stop]
  let center: UnitPoint
  let opacity: CGFloat
  let startRadius: CGFloat
  let endRadius: CGFloat?
  let endRadiusMultiplier: CGFloat
  let scaleEffectX: CGFloat
  let scaleEffectY: CGFloat
  
  func body(content: Content) -> some View {
    content
      .background(
      GeometryReader { geometry in
        RadialGradient(
          gradient: Gradient(stops: stops),
          center: center,
          startRadius: startRadius,
          endRadius: endRadius ?? min(geometry.size.width, geometry.size.height) * endRadiusMultiplier
        )
        .opacity(opacity)
        .scaleEffect(x: scaleEffectX, y: scaleEffectY)
      }
      .ignoresSafeArea(.all) // 여기에 추가
    )
  }
}

extension View {
  func radialGradientBackground(
    type: RadialGradient.RadialType,
    startRadius: CGFloat = 0.0,
    endRadius: CGFloat? = nil,
    endRadiusMultiplier: CGFloat = 1.0,
    scaleEffectX: CGFloat = 1.0,
    scaleEffectY: CGFloat = 1.0
  ) -> some View {
    self.modifier(
      RadialGradientBackground(
        stops: type.stops,
        center: type.center,
        opacity: type.opacity,
        startRadius: startRadius,
        endRadius: endRadius,
        endRadiusMultiplier: endRadiusMultiplier,
        scaleEffectX: scaleEffectX,
        scaleEffectY: scaleEffectY
      )
    )
  }
}
