//
//  FortuneCoreView.swift
//  Flifin
//
//  Created by 김유빈 on 6/28/25.
//

import SwiftUI

struct FortuneCoreView: View {
  let score: Int
  let action: () -> Void

  private var fortuneScore: FortuneScore {
    FortuneScore(score: score)
  }

  var body: some View {
    Button(action: action) {
      VStack(spacing: 0) {
        Text("금전운")
          .textStyle(.body6)
          .foregroundStyle(ColorResource.Neutral._300.color)

        Text("\(score)점")
          .textStyle(.h3)
          .foregroundStyle(LinearGradient(fortuneScore.textGradient))
      }
      .padding(20)
      .background {
        Circle()
          .fill(
            LinearGradient(.fortuneFill)
              .opacity(0.15)
          )
          .frame(width: 80, height: 80)
          .overlay(
            Circle()
              .stroke(
                fortuneScore.strokeGradient.opacity(0.28),
                lineWidth: 1
              )
          )
      }
    }
  }
}

enum FortuneScore {
  case top, mid, low

  init(score: Int) {
    switch score {
    case 0...40:
      self = .low
    case 41...70:
      self = .mid
    case 71...100:
      self = .top
    default:
      self = .low
    }
  }

  var strokeGradient: LinearGradient {
    switch self {
    case .low:
      return LinearGradient(.fortuneBorderLow)
    case .mid:
      return LinearGradient(.fortuneBorderMid)
    case .top:
      return LinearGradient(.fortuneBorderTop)
    }
  }

  var textGradient: LinearGradient.LinearType {
    switch self {
    case .low:
      return .fortuneGradientLow
    case .mid:
      return .fortuneGradientMid
    case .top:
      return .fortuneGradientTop
    }
  }
}

#Preview {
  FortuneCoreView(score: 35) {}
  FortuneCoreView(score: 60) {}
  FortuneCoreView(score: 100) {}
}
