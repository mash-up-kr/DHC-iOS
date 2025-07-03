//
//  TabKind.swift
//  Flifin
//
//  Created by Aiden.lee on 6/8/25.
//

import Foundation

enum TabKind {
  case home
  case report
  case myPage

  var title: String {
    switch self {
    case .home:
      return "홈"
    case .report:
      return "리포트"
    case .myPage:
      return "마이페이지"
    }
  }
}
