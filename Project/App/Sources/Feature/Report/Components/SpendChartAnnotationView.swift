//
//  SpendChartAnnotationView.swift
//  Flifin
//
//  Created by Aiden.lee on 6/22/25.
//

import SwiftUI

/// 말풍선 모양의 Annotation 뷰
struct SpendChartAnnotationView: View {
  let item: SpendChartData

  var body: some View {
    VStack(spacing: 0) {
      // 말풍선 본체
      Text(item.formatAmount)
        .textStyle(
          item.isHighlighted
            ? Typography.Head.h7
            : Typography.Body.body5
        )
        .foregroundStyle(
          item.isHighlighted
            ? ColorResource.Violet._300.color
            : ColorResource.Neutral._200.color
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(ColorResource.Neutral._600.color)
        .cornerRadius(4)

      // 말풍선 꼬리 (하단이 둥근 역삼각형)
      RoundedInvertedTriangle()
        .fill(ColorResource.Neutral._600.color)
        .frame(width: 12, height: 8)
    }
  }

  /// 하단이 둥근 역삼각형
  struct RoundedInvertedTriangle: Shape {
    let radius: CGFloat = 2.5

    func path(in rect: CGRect) -> Path {
      Path { path in
        let topLeft = CGPoint(x: rect.minX, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)

        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addArc(tangent1End: bottom, tangent2End: topLeft, radius: radius)
        path.addLine(to: topLeft)
      }
    }
  }
}

#Preview {
  VStack {
    SpendChartAnnotationView(
      item: .init(
        category: "나",
        amount: 52000,
        isHighlighted: true
      )
    )

    SpendChartAnnotationView(
      item: .init(
        category: "20대 남성",
        amount: 80000,
        isHighlighted: false
      )
    )
  }
}
