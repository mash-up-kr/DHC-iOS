//
//  MissionHistoryCalendar.swift
//  Flifin
//
//  Created by Aiden.lee on 7/2/25.
//

import Foundation

struct MissionHistoryCalendar: Equatable {
  let monthlyHistory: [MonthlyMissionHistory]
}

struct MonthlyMissionHistory: Equatable {
  let month: Int
  let averageSucceedProbability: Int
  let missionHistoryDateList: [MissionHistoryDate]
}

struct MissionHistoryDate: Equatable {
  let day: Int
  let date: String
  let finishedMissionCount: Int
  let totalMissionCount: Int
}
