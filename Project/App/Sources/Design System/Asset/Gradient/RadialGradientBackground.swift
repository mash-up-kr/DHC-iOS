//
//  RadialGradientBackground.swift
//  Flifin
//
//  Created by Aiden.lee on 6/14/25.
//

import SwiftUI

struct RadialGradientBackground: ViewModifier {
  let color: Color
  let startRadius: CGFloat
  let endRadius: CGFloat?
  let endRadiusMultiplier: CGFloat
  let scaleEffectX: CGFloat
  let scaleEffectY: CGFloat

  func body(content: Content) -> some View {
    content.background(
      GeometryReader { geometry in
        RadialGradient(
          gradient: Gradient(stops: [
            .init(color: color, location: 0.23),
            .init(color: color.opacity(0.3), location: 0.51),
            .init(color: color.opacity(0.1), location: 0.75),
            .init(color: color.opacity(0.05), location: 0.88),
            .init(color: color.opacity(0), location: 1.0),
          ]),
          center: .init(x: UnitPoint.center.x, y: UnitPoint.center.y + 0.09),
          startRadius: startRadius,
          endRadius: endRadius ?? min(geometry.size.width, geometry.size.height) * endRadiusMultiplier
        )
        .scaleEffect(x: scaleEffectX, y: scaleEffectY)
      }
    )
  }
}

extension View {
  func radialGradientBackground(
    color: Color = ColorResource.Violet._400.color,
    center: UnitPoint = .center,
    startRadius: CGFloat = 0.0,
    endRadius: CGFloat? = nil,
    endRadiusMultiplier: CGFloat = 1.0,
    scaleEffectX: CGFloat = 1.0,
    scaleEffectY: CGFloat = 1.0
  ) -> some View {
    self.modifier(
      RadialGradientBackground(
        color: color,
        startRadius: startRadius,
        endRadius: endRadius,
        endRadiusMultiplier: endRadiusMultiplier,
        scaleEffectX: scaleEffectX,
        scaleEffectY: scaleEffectY
      )
    )
  }
}
