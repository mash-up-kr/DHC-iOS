//
//  HomeDTO.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

struct HomeDTO: Decodable {
  let longTermMission: MissionInfo
  let todayDailyMissionList: [MissionInfo]
  let todayDailyFortune: DailyFortuneInfo
  let todayDone: Bool
}

extension HomeDTO {
  struct MissionInfo: Decodable {
    let missionId: String
    let category: String
    let difficulty: Int
    let type: String
    let finished: Bool
    let cost: String
    let endDate: String
    let title: String
    let switchCount: Int
  }
}

extension HomeDTO {
  struct DailyFortuneInfo: Decodable {
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
    
    enum CodingKeys: String, CodingKey {
      case date
      case fortuneTitle
      case fortuneDetail
      case jinxedColor
      case jinxedColorHex
      case jinxedMenu
      case jinxedNumber
      case luckyColor
      case luckyColorHex
      case luckyNumber
      case score = "totalScore"
      case todayMenu
    }
  }
}

extension HomeDTO {
  func toDomain() -> HomeInfo {
    HomeInfo(
      longTermMission: .init(
        missionId: longTermMission.missionId,
        category: longTermMission.category,
        difficulty: longTermMission.difficulty,
        type: longTermMission.type,
        finished: longTermMission.finished,
        cost: longTermMission.cost,
        endDate: longTermMission.endDate,
        title: longTermMission.title,
        switchCount: longTermMission.switchCount
      ),
      todayDailyMissionList: todayDailyMissionList.map {
        .init(
          missionId: $0.missionId,
          category: $0.category,
          difficulty: $0.difficulty,
          type: $0.type,
          finished: $0.finished,
          cost: $0.cost,
          endDate: $0.endDate,
          title: $0.title,
          switchCount: $0.switchCount
        )
      },
      todayDailyFortune: .init(
        date: todayDailyFortune.date,
        fortuneTitle: todayDailyFortune.fortuneTitle,
        fortuneDetail: todayDailyFortune.fortuneDetail,
        jinxedColor: todayDailyFortune.jinxedColor,
        jinxedColorHex: todayDailyFortune.jinxedColorHex,
        jinxedMenu: todayDailyFortune.jinxedMenu,
        jinxedNumber: todayDailyFortune.jinxedNumber,
        luckyColor: todayDailyFortune.luckyColor,
        luckyColorHex: todayDailyFortune.luckyColorHex,
        luckyNumber: todayDailyFortune.luckyNumber,
        score: todayDailyFortune.score,
        todayMenu: todayDailyFortune.todayMenu
      ),
      todayDone: todayDone
    )
  }
}
