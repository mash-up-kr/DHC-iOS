//
//  CalendarMissionCompletionStage.swift
//  Flifin
//
//  Created by Aiden.lee on 7/2/25.
//

import SwiftUI

enum CalendarMissionCompletionStage {
  /// 미션 0개 수행
  case none
  /// 미션 1개 수행
  case one
  /// 미션 2개 수행
  case two
  /// 미션 3개 이상 수행
  case all

  init(completionCount: Int) {
    switch completionCount {
    case 0:
      self = .none
    case 1:
      self = .one
    case 2:
      self = .two
    case 3...:
      self = .all
    default:
      self = .none
    }
  }
}

extension CalendarMissionCompletionStage {
  var displayColor: Color? {
    switch self {
    case .none:
      return nil
    case .one:
      return ColorResource.Violet._400.color.opacity(0.35)
    case .two:
      return ColorResource.Violet._400.color.opacity(0.70)
    case .all:
      return ColorResource.Text.Highlights.primary.color
    }
  }
}
