//
//  FlippableFortuneCardView.swift
//  Flifin
//
//  Created by 최혜린 on 7/1/25.
//

import SwiftUI

struct FlippableCard<Front: View, Back: View>: View {
  @State private var rotationAngle: Double = 0
  @State private var isFlipped = false
  private var frontContent: Front
  private var backContent: Back
  private let flipCompletion: () -> Void
  
  init(
    frontContent: () -> Front,
    backContent: () -> Back,
    flipCompletion: @escaping () -> Void
  ) {
    self.frontContent = frontContent()
    self.backContent = backContent()
    self.flipCompletion = flipCompletion
  }
  
  private let flipThreshold: CGFloat = 90
  
  var body: some View {
    ZStack {
      backContent
        .opacity(shouldShowBack ? 1 : 0)
        .rotation3DEffect(
          .degrees(rotationAngle + 180),
          axis: (x: 0, y: 1, z: 0),
          perspective: 0.5
        )
      
      frontContent
        .opacity(shouldShowBack ? 0 : 1)
        .rotation3DEffect(
          .degrees(rotationAngle),
          axis: (x: 0, y: 1, z: 0),
          perspective: 0.5
        )
    }
    .frame(width: 144, height: 200)
    .gesture(
      DragGesture()
        .onChanged { value in
          // 드래그 거리에 따른 회전 각도 계산
          let dragDistance = value.translation.width
          rotationAngle = Double(dragDistance / 3)
        }
        .onEnded { value in
          let dragDistance = value.translation.width
          
          withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            if dragDistance > flipThreshold {
              rotationAngle = ((rotationAngle / 180).rounded(.up)) * 180
              isFlipped.toggle()
            } else if dragDistance < -flipThreshold {
              rotationAngle = ((rotationAngle / 180).rounded(.down)) * 180
              isFlipped.toggle()
            } else {
              rotationAngle = (rotationAngle / 180).rounded() * 180
            }
          } completion: {
            if isFlipped {
              flipCompletion()
            }
          }
        }
    )
  }
  
  private var shouldShowBack: Bool {
    let normalizedAngle = rotationAngle.truncatingRemainder(dividingBy: 360)
    let positiveAngle = normalizedAngle >= 0 ? normalizedAngle : normalizedAngle + 360
    
    return positiveAngle >= 90 && positiveAngle <= 270
  }
}
