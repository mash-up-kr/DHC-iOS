//
//  MissionHistoryCalendarDTO.swift
//  Flifin
//
//  Created by Aiden.lee on 7/2/25.
//

import Foundation

struct MissionHistoryCalendarDTO: Decodable {
  let threeMonthViewResponse: [MonthlyMissionCalendar]
}

extension MissionHistoryCalendarDTO {
  struct MonthlyMissionCalendar: Decodable {
    let month: Int
    let averageSucceedProbability: Int
    let calendarDayMissionViews: [CalendarDayMission]
  }

  struct CalendarDayMission: Decodable {
    let day: Int
    let date: String
    let finishedMissionCount: Int
    let totalMissionCount: Int
  }
}

extension MissionHistoryCalendarDTO {
  func toDomain() -> MissionHistoryCalendar {
    MissionHistoryCalendar(
      monthlyHistory: threeMonthViewResponse.map { $0.toDomain() }
    )
  }
}

extension MissionHistoryCalendarDTO.MonthlyMissionCalendar {
  func toDomain() -> MonthlyMissionHistory {
    MonthlyMissionHistory(
      month: month,
      averageSucceedProbability: averageSucceedProbability,
      missionHistoryDateList: calendarDayMissionViews.map { $0.toDomain() }
    )
  }
}

extension MissionHistoryCalendarDTO.CalendarDayMission {
  func toDomain() -> MissionHistoryDate {
    MissionHistoryDate(
      day: day,
      date: date,
      finishedMissionCount: finishedMissionCount,
      totalMissionCount: totalMissionCount
    )
  }
}
