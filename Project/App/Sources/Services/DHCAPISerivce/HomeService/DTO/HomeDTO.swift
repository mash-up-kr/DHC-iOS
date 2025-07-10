//
//  HomeDTO.swift
//  Flifin
//
//  Created by 김유빈 on 7/2/25.
//

import Foundation

struct HomeDTO: Decodable {
  let longTermMission: MissionInfo
  let dailyMissionList: [MissionInfo]
  let todayFortune: DailyFortuneInfo
  let isTodayMissionDone: Bool
  
  enum CodingKeys: String, CodingKey {
    case longTermMission
    case dailyMissionList = "todayDailyMissionList"
    case todayFortune = "todayDailyFortune"
    case isTodayMissionDone = "todayDone"
  }
}

extension HomeDTO {
  struct MissionInfo: Decodable {
    let missionID: String
    let category: String
    let difficulty: Int
    let type: String
    let isFinished: Bool
    let cost: String
    let endDate: String
    let title: String
    let switchCount: Int
    
    enum CodingKeys: String, CodingKey {
      case missionID = "missionId"
      case category
      case difficulty
      case type
      case isFinished = "finished"
      case cost
      case endDate
      case title
      case switchCount
    }
  }
}

extension HomeDTO {
  struct DailyFortuneInfo: Decodable {
    let date: String
    let fortuneTitle: String
    let fortuneDetail: String
    let jinxedColor: String
    let jinxedColorHex: String
    let jinxedColorImage: String
    let jinxedMenu: String
    let jinxedMenuImage: String
    let jinxedNumber: Int
    let luckyColor: String
    let luckyColorHex: String
    let luckyColorImage: String
    let luckyNumber: Int
    let positiveScore: Int
    let negativeScore: Int
    let todayMenu: String
    let todayMenuImage: String
    let score: Int
    let luckyColorType: String
    let jinxedColorType: String
    let fortuneCardImage: String
    
    enum CodingKeys: String, CodingKey {
      case date
      case fortuneTitle
      case fortuneDetail
      case jinxedColor
      case jinxedColorHex
      case jinxedColorImage
      case jinxedMenu
      case jinxedMenuImage
      case jinxedNumber
      case luckyColor
      case luckyColorHex
      case luckyColorImage
      case luckyNumber
      case positiveScore
      case negativeScore
      case todayMenu
      case todayMenuImage
      case score = "totalScore"
      case luckyColorType
      case jinxedColorType
      case fortuneCardImage
    }
  }
}

extension HomeDTO {
  func toDomain() -> HomeInfo {
    HomeInfo(
      longTermMission: .init(
        id: longTermMission.missionID,
        category: longTermMission.category,
        difficulty: longTermMission.difficulty,
        type: longTermMission.type,
        isFinished: longTermMission.isFinished,
        cost: longTermMission.cost,
        endDate: longTermMission.endDate,
        title: longTermMission.title,
        switchCount: longTermMission.switchCount
      ),
      dailyMissionList: dailyMissionList.map {
        .init(
          id: $0.missionID,
          category: $0.category,
          difficulty: $0.difficulty,
          type: $0.type,
          isFinished: $0.isFinished,
          cost: $0.cost,
          endDate: $0.endDate,
          title: $0.title,
          switchCount: $0.switchCount
        )
      },
      dailyFortune: .init(
        date: todayFortune.date,
        fortuneTitle: todayFortune.fortuneTitle,
        fortuneDetail: todayFortune.fortuneDetail,
        jinxedColor: todayFortune.jinxedColor,
        jinxedColorHex: todayFortune.jinxedColorHex,
        jinxedColorImage: todayFortune.jinxedColorImage,
        jinxedMenu: todayFortune.jinxedMenu,
        jinxedMenuImage: todayFortune.jinxedMenuImage,
        jinxedNumber: todayFortune.jinxedNumber,
        luckyColor: todayFortune.luckyColor,
        luckyColorHex: todayFortune.luckyColorHex,
        luckyColorImage: todayFortune.luckyColorImage,
        luckyNumber: todayFortune.luckyNumber,
        positiveScore: todayFortune.positiveScore,
        negativeScore: todayFortune.negativeScore,
        todayMenu: todayFortune.todayMenu,
        todayMenuImage: todayFortune.todayMenuImage,
        score: todayFortune.score,
        luckyColorType: todayFortune.luckyColorType,
        jinxedColorType: todayFortune.jinxedColorType,
        fortuneCardImage: todayFortune.fortuneCardImage
      ),
      isTodayMissionDone: isTodayMissionDone
    )
  }
}
