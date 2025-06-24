//
//  TabKind.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

enum TabKind {
  case home
  case missionStatus
  case myPage

  var title: String {
    switch self {
    case .home:
      return "홈"
    case .missionStatus:
      return "미션 현황"
    case .myPage:
      return "마이페이지"
    }
  }
}
