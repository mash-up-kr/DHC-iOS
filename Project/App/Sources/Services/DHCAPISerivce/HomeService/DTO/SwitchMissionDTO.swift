//
//  SwitchMissionDTO.swift
//  Flifin
//
//  Created by 김유빈 on 7/16/25.
//

struct SwitchMissionDTO: Decodable {
    let missions: [HomeDTO.MissionInfo]
}

extension SwitchMissionDTO {
  func toDomain() -> SwitchMissionInfo {
        let missions = missions.map {
            HomeInfo.Mission(
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
        }

        let longTermMission = missions.first(where: { $0.type == "LONG_TERM" })!
        let dailyMissions = missions.filter { $0.type == "DAILY" }

    return SwitchMissionInfo(longTermMission: longTermMission, dailyMissionList: dailyMissions)
    }
}
