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
  let todayFortune: FortuneDetailDTO
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
        title: todayFortune.fortuneTitle,
        score: todayFortune.totalScore,
        cardImageURL: URL(string: todayFortune.cardInfo.image),
        cardTitle: todayFortune.cardInfo.title,
        cardSubTitle: todayFortune.cardInfo.subTitle
      ),
      isTodayMissionDone: isTodayMissionDone
    )
  }
}
