//
//  HomeInfo.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

struct HomeInfo: Equatable {
  let longTermMission: Mission
  let dailyMissionList: [Mission]
  let dailyFortune: DailyFortune
  var isTodayMissionDone: Bool
}

extension HomeInfo {
  struct Mission: Equatable {
    let id: String
    let category: String
    let difficulty: Int
    let type: String
    var isFinished: Bool
    let cost: String
    let endDate: String
    let title: String
    let switchCount: Int
  }

  struct DailyFortune: Equatable {
    let date: String
    let title: String
    let positiveScore: Int
    let negativeScore: Int
    let score: Int
    let cardImage: String
    let cardTitle: String
    let cardSubTitle: String
  }
}

extension HomeInfo {
  static let sample = HomeInfo(
    longTermMission: .init(
      id: "long-term-001",
      category: "생활",
      difficulty: 3,
      type: "LONG_TERM",
      isFinished: false,
      cost: "25000",
      endDate: "2025-07-18",
      title: "주중 3일 승용차 대신 대중교통 이용하기",
      switchCount: 1
    ),
    dailyMissionList: [
      .init(
        id: "daily-001",
        category: "이동·교통",
        difficulty: 3,
        type: "DAILY",
        isFinished: false,
        cost: "24000",
        endDate: "2025-07-05",
        title: "하루 동안 승용차 대신 대중교통 타기",
        switchCount: 0
      ),
      .init(
        id: "daily-002",
        category: "이동·교통",
        difficulty: 2,
        type: "DAILY",
        isFinished: false,
        cost: "12000",
        endDate: "2025-07-05",
        title: "도보 10분 이내 거리 무조건 걷기",
        switchCount: 0
      ),
      .init(
        id: "daily-003",
        category: "이동·교통",
        difficulty: 1,
        type: "DAILY",
        isFinished: false,
        cost: "4000",
        endDate: "2025-07-05",
        title: "따릉이(공공자전거) 이용하기",
        switchCount: 0
      ),
    ],
    dailyFortune: .init(
      date: "2025-07-09",
      title: "투자 아이디어! 신중한 판단이 필요한 날",
      positiveScore: 100,
      negativeScore: 0,
      score: 100,
      cardImage: "https://kr.object.ncloudstorage.com/dhc-object-storage/logos/mainCard/png/fourLeafClover.png",
      cardTitle: "",
      cardSubTitle: ""
    ),
    isTodayMissionDone: false
  )
}

extension HomeInfo.Mission {
  static func onboardingLongTermMisson(endDate: String) -> HomeInfo.Mission {
    .init(
      id: "-1",
      category: "식음료",
      difficulty: 5,
      type: "LONG_TERM",
      isFinished: false,
      cost: "100.00",
      endDate: endDate,
      title: "도시락 싸서 점심·저녁 해결하기",
      switchCount: 0
    )
  }

  static let onboardingDailyMissionList: [HomeInfo.Mission] = [
    .init(
      id: "0",
      category: "취미·문화",
      difficulty: 1,
      type: "DAILY",
      isFinished: false,
      cost: "100.00",
      endDate: "2024-12-31",
      title: "간식은 집에서 챙겨 다니기",
      switchCount: 0
    ),
    .init(
      id: "1",
      category: "취미·문화",
      difficulty: 1,
      type: "DAILY",
      isFinished: false,
      cost: "100.00",
      endDate: "2024-12-31",
      title: "아침 집밥 챙겨먹기",
      switchCount: 0
    ),
    .init(
      id: "2",
      category: "취미·문화",
      difficulty: 1,
      type: "DAILY",
      isFinished: false,
      cost: "100.00",
      endDate: "2024-12-31",
      title: "커피는 집에서 내려 마시기",
      switchCount: 0
    ),
    .init(
      id: "3",
      category: "취미·문화",
      difficulty: 1,
      type: "DAILY",
      isFinished: false,
      cost: "100.00",
      endDate: "2024-12-31",
      title: "음료 구매할때 텀블러 할인받기",
      switchCount: 0
    ),
    .init(
      id: "4",
      category: "취미·문화",
      difficulty: 1,
      type: "DAILY",
      isFinished: false,
      cost: "100.00",
      endDate: "2024-12-31",
      title: "오늘 하루 배달앱 알림 꺼두기",
      switchCount: 0
    ),
  ]
}
