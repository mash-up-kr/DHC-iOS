//
//  View+Loading.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import SwiftUI

extension View {
  /// 로딩 오버레이를 표시합니다.
  ///
  /// - Parameters:
  ///   - isLoading: 로딩 상태
  /// - Returns: 로딩 오버레이가 적용된 뷰
  func loadingOverlay(
    isLoading: Bool,
    needsDimming: Bool = true
  ) -> some View {
    self
      .overlay {
        if isLoading {
          DHCLoadingOverlay(needsDimming: needsDimming)
        }
      }
  }
}
