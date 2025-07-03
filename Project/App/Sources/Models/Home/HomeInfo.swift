//
//  HomeInfo.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

struct HomeInfo: Equatable {
  let longTermMission: Mission
  let todayDailyMissionList: [Mission]
  let todayDailyFortune: DailyFortune
  var todayDone: Bool
}

extension HomeInfo {
  struct Mission: Equatable {
    let missionId: String
    let category: String
    let difficulty: Int
    let type: String
    var finished: Bool
    let cost: String
    let endDate: String
    let title: String
    let switchCount: Int
  }

  struct DailyFortune: Equatable {
    let date: String
    let fortuneTitle: String
    let fortuneDetail: String
    let jinxedColor: String
    let jinxedColorHex: String
    let jinxedMenu: String
    let jinxedNumber: Int
    let luckyColor: String
    let luckyColorHex: String
    let luckyNumber: Int
    let score: Int
    let todayMenu: String
  }
}

extension HomeInfo {
  static let sample = HomeInfo(
    longTermMission: .init(
      missionId: "507f1f77bcf86cd799439033",
      category: "취미·문화",
      difficulty: 5,
      type: "LONG_TERM",
      finished: false,
      cost: "100.00",
      endDate: "2024-12-31",
      title: "여행 가기 위해 돈 모으기",
      switchCount: 0
    ),
    todayDailyMissionList: [
      .init(
        missionId: "507f1f77bcf86cd799439044",
        category: "식음료",
        difficulty: 2,
        type: "DAILY",
        finished: false,
        cost: "15.00",
        endDate: "2024-01-15",
        title: "점심 도시락 싸가기",
        switchCount: 1
      ),
      .init(
        missionId: "507f1f77bcf86cd799439055",
        category: "이동·교통",
        difficulty: 1,
        type: "DAILY",
        finished: true,
        cost: "5.00",
        endDate: "2024-01-15",
        title: "대중교통 이용하기",
        switchCount: 0
      )
    ],
    todayDailyFortune: .init(
      date: "2024-01-15",
      fortuneTitle: "좋은 하루",
      fortuneDetail: "오늘은 좋은 일이 생길 것입니다",
      jinxedColor: "빨간색",
      jinxedColorHex: "#FF0000",
      jinxedMenu: "매운 음식",
      jinxedNumber: 4,
      luckyColor: "파란색",
      luckyColorHex: "#0000FF",
      luckyNumber: 7,
      score: 85,
      todayMenu: "샐러드"
    ), 
    todayDone: false
  )
}
