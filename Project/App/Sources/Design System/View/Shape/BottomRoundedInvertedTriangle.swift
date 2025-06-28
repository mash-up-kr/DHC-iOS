//
//  BottomRoundedInvertedTriangle.swift
//  ProductName
//
//  Created by hyerin on 6/20/25.
//

import SwiftUI

struct BottomRoundedInvertedTriangle: Shape {
  private let cornerRadius: CGFloat
  
  init(cornerRadius: CGFloat) {
    self.cornerRadius = cornerRadius
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    let width = rect.width
    let height = rect.height
    let radius = cornerRadius
    
    // 왼쪽 위에서 시작 (완전히 모서리부터)
    path.move(to: CGPoint(x: 0, y: 0))
    
    // 위쪽 직선 (오른쪽 위까지)
    path.addLine(to: CGPoint(x: width, y: 0))
    
    // 오른쪽 대각선 (아래 둥근 부분 전까지)
    path.addLine(to: CGPoint(x: width/2 + radius * 0.7, y: height - radius))
    
    // 아래쪽 둥근 모서리
    path.addQuadCurve(
      to: CGPoint(x: width/2 - radius * 0.7, y: height - radius),
      control: CGPoint(x: width/2, y: height)
    )
    
    // 왼쪽 대각선 (왼쪽 위까지)
    path.addLine(to: CGPoint(x: 0, y: 0))
    
    return path
  }
}
