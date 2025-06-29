//
//  DHCLoadingSpinner.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import SwiftUI

struct DHCLoadingSpinner: View {
  @State private var isAnimating = false
  private let size: CGFloat = 40
  private let strokeWidth: CGFloat = 8
  private let gradient = AngularGradient(
    gradient: Gradient(colors: [ColorResource._2_D_2_D_2_D.color, .white]),
    center: .center,
    startAngle: .degrees(.zero),
    endAngle: .degrees(360)
  )

  var body: some View {
    ZStack {
      Circle()
        .stroke(
          gradient,
          style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
        )
        .frame(width: size, height: size)
        .rotationEffect(.degrees(isAnimating ? 360 : 0))
        .animation(
          .linear(duration: 1)
            .repeatForever(autoreverses: false),
          value: isAnimating
        )
    }
    .onAppear {
      startAnimation()
    }
  }

  private func startAnimation() {
    withAnimation {
      isAnimating = true
    }
  }
}

// MARK: - 로딩 오버레이 뷰

struct DHCLoadingOverlay: View {

  let needsDimming: Bool

  var body: some View {
    ZStack {
      if needsDimming {
        ColorResource.Background.main.color.opacity(0.8)
          .ignoresSafeArea()
      }

      DHCLoadingSpinner()
    }
  }
}

#Preview("Loading Spinner") {
  VStack(spacing: 40) {
    DHCLoadingOverlay(needsDimming: true)
  }
}
