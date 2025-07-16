//
//  SwitchMissionInfo.swift
//  Flifin
//
//  Created by 김유빈 on 7/16/25.
//

import Foundation

struct SwitchMissionInfo: Equatable {
  let longTermMission: HomeInfo.Mission
  let dailyMissionList: [HomeInfo.Mission]
}

extension SwitchMissionInfo {
  static let sample = SwitchMissionInfo(
    longTermMission: .init(
      id: "long-term-mission-id",
      category: "쇼핑",
      difficulty: 3,
      type: "LONG_TERM",
      isFinished: true,
      cost: "10000",
      endDate: "2025-07-03",
      title: "신용카드 결제는 할부 금지하기",
      switchCount: 0
    ),
    dailyMissionList: [
      .init(
        id: "daily-mission-id-01",
        category: "쇼핑",
        difficulty: 1,
        type: "DAILY",
        isFinished: false,
        cost: "6000",
        endDate: "2025-06-29",
        title: "오프라인 매장·쇼핑몰 둘러보기 10분 제한하기",
        switchCount: 0
      ),
      .init(
        id: "daily-mission-id-02",
        category: "쇼핑",
        difficulty: 1,
        type: "DAILY",
        isFinished: false,
        cost: "12000",
        endDate: "2025-06-29",
        title: "할인행사 '첫 1시간 지나서 입장'",
        switchCount: 0
      ),
      .init(
        id: "daily-mission-id-03",
        category: "쇼핑",
        difficulty: 2,
        type: "DAILY",
        isFinished: false,
        cost: "30000",
        endDate: "2025-06-29",
        title: "오늘 하루 지출 충동 기록하기",
        switchCount: 0
      ),
    ]
  )
}
